;; Ceci est une configuration de système d'exploitation générée par
;; l'installateur graphique.
;;
;; Une fois l'installation terminée, vous pouvez apprendre à modifier
;; ce fichier pour ajuster la configuration du système et le passer à
;; la commande « guix system reconfigure » pour rendre vos changements
;; effectifs.


;; Indique quels modules importer pour accéder aux variables
;; utilisées dans cette configuration.
;; Modules nécessaires
(use-modules (gnu)
             (gnu system)
             (gnu packages)
             (gnu services)
             (gnu services desktop)
             (gnu services spice)
             (gnu services networking)
             (gnu services ssh)
             (gnu services xorg))

(operating-system
  (locale "fr_FR.utf8")
  (timezone "Europe/Paris")
  (keyboard-layout (keyboard-layout "fr"))
  (host-name "guix-kvm")

  (users (cons* (user-account
                  (name "minegame")
                  (comment "Minegame YTB")
                  (group "users")
                  (home-directory "/home/minegame")
                  (supplementary-groups '("wheel" "netdev" "audio" "video")))
                %base-user-accounts))

  (packages
    (append
      (map specification->package
           '("htop" "neovim" "openssh" "git" "xdg-utils"))
      %base-packages))

  (services
   (append
     (list (service gnome-desktop-service-type)
           (service spice-vdagent-service-type)
           (set-xorg-configuration
            (xorg-configuration (keyboard-layout keyboard-layout))))
     %desktop-services))

  (bootloader (bootloader-configuration
                (bootloader grub-efi-bootloader)
                (targets (list "/boot/efi"))
                (keyboard-layout keyboard-layout)))

  (swap-devices
    (list (swap-space
            (target (uuid "64fd0749-a41e-4efe-a915-656d4165beb8")))))

  (file-systems
    (cons* (file-system
             (mount-point "/boot/efi")
             (device (uuid "3437-97C4" 'fat32))
             (type "vfat"))
           (file-system
             (mount-point "/")
             (device (uuid "25a88ba2-5c14-4f71-bf29-6fc962f842bc" 'ext4))
             (type "ext4"))
           %base-file-systems)))
