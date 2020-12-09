# # # # # # # # # # # # # # # # # # # # # # #
# Failover Cluster Automation, by @v-itcarr #
# # # # # # # # # # # # # # # # # # # # # # # 

[int]$option = $null
function menu {

    Clear-Host
    Write-Host " 1. Red TCPIP"; Write-Host " 2. Hotfixes";
    Write-Host " 3. Configuracion de Discos"; Write-Host " 4. Failover Cluster";
    Write-Host " 5. Asignar permisos en Active Directory"; Write-Host " 0. Salir";
    
    $option = Read-Host " Selecciona una opcion"

    if ($option -eq 1){ # Network
        function network {

            Clear-Variable option; Clear-Host;
            Write-Host " 1. PING"; Write-Host " 2. Conectividad (WinRM)"; Write-Host " 3. Resolucion DNS"
            Write-Host " 4. Adaptadores de Red"; Write-Host " 5. Firewall"; Write-Host " 0. Regresar"

            $option = Read-Host " Seleccciona una opcion"
        
            if ($option -eq 1) { .\modules\network\pingTest.exe; network; } #Ping
            elseif ($option -eq 2) { .\modules\network\winRM.exe; network; } #WinRM
            elseif ($option -eq 3) { .\modules\network\dns.exe; network; } #DNS
            elseif ($option -eq 4) { .\modules\network\nic.exe; network; } #NICS
            elseif ($option -eq 5) { .\modules\network\fw.exe; network; } #Firewall
            elseif ($option -eq 0) { return menu; } #Regresar
            else { return network; } #Invalid option
        }; network
                        
    } elseif ($option -eq 2) { .\modules\hotfix.exe; menu; } #Hotfixes

    elseif ($option -eq 3) { # Discos
        function disks {
            Clear-Variable option; Clear-Host;
            Write-Host " 1. Inicializar discos"; Write-Host " 2. Generar archivo de configuracion"
            Write-Host " 3. Crear volumenes"; Write-Host " 4. Configurar monturas"; Write-Host " 0. Regresar";

            $option = Read-Host " Seleccciona una opcion"

            if ($option -eq 1) { .\modules\disks\ini.exe; disks; } #Initializate
            elseif ($option -eq 2) { .\modules\disks\configFile.exe; disks; } #Configuration File for Disks
            elseif ($option -eq 3) { .\modules\disks\createVol.exe; disks; } #Create Volumes
            elseif ($option -eq 4) { .\modules\disks\monturas.exe; disks; } #Monturas
            elseif ($option -eq 0) { return menu; } #Regresar
            else { return disks;}
        }; disks
        
    } elseif ($option -eq 4) { # Cluster
        function cluster {
            Clear-Host; Clear-Variable option;
            Write-Host " 1. Instalar Failover Clustering"; Write-Host " 2. Crear Cluster";
            Write-Host " 3. Renombrar Adaptadores de Red"; Write-Host " 4. Renombrar Discos";
            Write-Host " 5. Reporte de Validacion"; Write-Host " 0. Regresar";

            $option = Read-Host " Seleccciona una opcion"

            if ($option -eq 1) { .\modules\cluster\installFeature.exe; cluster; } #Install FC Feature
            elseif ($option -eq 2) { .\modules\cluster\createCluster.exe; cluster; } #Create/Config Cluster
            elseif ($option -eq 3) { .\modules\cluster\renameNICs.exe; cluster; } #Rename Cluster NICs
            elseif ($option -eq 4) { .\modules\cluster\renameDisks.exe; cluster; } #Rename Cluster Disks
            #elseif ($option -eq 5) { .\modules\cluster\installFS.ps1; cluster; } #Install FS role
            elseif ($option -eq 5) { .\modules\cluster\report.exe; cluster; } #Validation Report
            elseif ($option -eq 0) { return menu; } #Regresar
            else { return cluster; }
        }; cluster

    }  elseif ($option -eq 5) { .\modules\ad.exe; menu; } #AD
    
    elseif ($option -eq 0) { } #Empty, Exit
    else { return menu; }
}; menu