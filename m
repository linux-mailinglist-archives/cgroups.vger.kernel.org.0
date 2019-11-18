Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F402100E7D
	for <lists+cgroups@lfdr.de>; Mon, 18 Nov 2019 22:58:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfKRV6f (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 18 Nov 2019 16:58:35 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45839 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbfKRV6e (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 18 Nov 2019 16:58:34 -0500
Received: by mail-qt1-f196.google.com with SMTP id 30so22067400qtz.12
        for <cgroups@vger.kernel.org>; Mon, 18 Nov 2019 13:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PGxrNAmObTxUOtbWyM42VXGDhKoOxnyZ2Rx/ezuiN6U=;
        b=jUUil8Tmg6jm98HSAZWjpWhErltlyW0+1lvj6K69Z/SWjN3XY7zB4xpCs9pLNJd8Ps
         zMGJ5pGQckZ9HfHhfoZ20BdDALIVgOGSXLqjPPI4sGUs/z1ShIjz9XuWkxltJl6AJd9Z
         ygPlewX8tzCWs6BCJP4jEybAJ04XSv5pjNPmlGPVU1HJsdRCrqnB6OrY0T7Ucb8wGg4p
         5SbiI7TPZfhGQ8Hx0Z0Bykkhyms8l+S3qpMwSzUKtXhsW7WOLK7iAp9QZT0ua0BPMOP1
         u3d3y++JxDJ43fz1jkHfHg9PpenPCmipnts8J+nwUyezP8I7lgwFzyrmb2O+B3qCJdfW
         sJeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PGxrNAmObTxUOtbWyM42VXGDhKoOxnyZ2Rx/ezuiN6U=;
        b=YWaCA5E3lTfm+/m5eLrJBoq7TM3eVHO7ESS/KM4LErLMvTacCMUkfmu36Q1DwcwECj
         xCGXNb4LjNjVtPGVjvOLLBbIvb/59+WtsjPExQBYPicpbcDKDYqDTOQ+Oajt0MTyTHgb
         FP9mWSngQmLkLiU0wwgP9raEmQLPKtsNvqeggSWkXqoZ0qWQ0mTr/aG+l9xoWI5wJrE0
         0/qp28cIbe1qyr8re3aNqMESO5pabHc2NiOfCEzRbID9kswYmI0OaCiUELeXtchd7MFx
         L7vfPg2b2INwngJtK4dvHt0xy3DhgQH5tuCzIGrA032dMl9nQGvbbIT/VJ3aJYJ09SS+
         I7ZA==
X-Gm-Message-State: APjAAAUDtve3qh0aSGlth95GvZ1yuROmHG0E6y60AX2pFwi4vA3tYwkY
        oWC4rtYOy8y0YG8z1JMN5/E7UQ==
X-Google-Smtp-Source: APXvYqzkhsV4+eDtM8G/5Os/jblYIR+26A8JK/HNF6DVYlhg9eqDkgbDeYQOOwVZ2tTl2MGQty0zGw==
X-Received: by 2002:aed:24af:: with SMTP id t44mr28834514qtc.57.1574114311120;
        Mon, 18 Nov 2019 13:58:31 -0800 (PST)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id l132sm9351165qke.38.2019.11.18.13.58.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Nov 2019 13:58:30 -0800 (PST)
Message-ID: <1574114307.5937.152.camel@lca.pw>
Subject: Re: PSI: use-after-free in collect_percpu_times()
From:   Qian Cai <cai@lca.pw>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Date:   Mon, 18 Nov 2019 16:58:27 -0500
In-Reply-To: <1574113159.5937.148.camel@lca.pw>
References: <1574113159.5937.148.camel@lca.pw>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Wondering if this is cgroup v2 related, as the systems is running with
systemd.unified_cgroup_hierarchy=1 and accessing PSI via sysfs trigger this...

On Mon, 2019-11-18 at 16:39 -0500, Qian Cai wrote:
> Since a few days ago, s390 starts to crash on linux-next while reading some
> sysfs. It is not always reproducible but seems pretty reproducible after running
> the whole MM test suite here,
> https://github.com/cailca/linux-mm/blob/master/test.sh
> 
> the config:
> https://raw.githubusercontent.com/cailca/linux-mm/master/s390.config
> 
> The stack trace on s390 is not particular helpful as both gdb and faddr2line are
> unable to point out which line causes the issue.
> 
> # ./scripts/faddr2line vmlinux collect_percpu_times+0x2d6/0x798
> bad symbol size: base: 0x00000000002076f8 end: 0x00000000002076f8
> 
> (gdb) list *(collect_percpu_times+0x2d6)
> 0x2079ce is in collect_percpu_times (./include/linux/compiler.h:199).
> 194	})
> 195	
> 196	static __always_inline
> 197	void __read_once_size(const volatile void *p, void *res, int size)
> 198	{
> 199		__READ_ONCE_SIZE;
> 200	}
> 201	
> 202	#ifdef CONFIG_KASAN
> 203	/*
> 
> Could it be some race conditions in PSI?
> 
> 01: [ 9499.451788] LTP: starting read_all_sys (read_all -d /sys -q -r 10)       
> (zcon 17:55:45) [-- MARK --]
> 00: [ 9777.709470] =============================================================
> 00: =====                                                                       
> 00: [ 9777.709515] BUG: KASAN: use-after-free in collect_percpu_times+0x2d6/0x79
> 00: 8                                                                           
> 00: [ 9777.709530] Read of size 4 at addr 0000000066229000 by task read_all/5024
> 00: 0                                                                           
> 00: [ 9777.709543]                                                              
> 00: [ 9777.709559] CPU: 0 PID: 50240 Comm: read_all Not tainted 5.4.0-rc7-next-2
> 00: 0191118 #4                                                                  
> 00: [ 9777.709573] Hardware name: IBM 2964 N96 400 (z/VM 6.4.0)                 
> 00: [ 9777.709586] Call Trace:                                                  
> 00: [ 9777.709604] ([<000000000568e202>] show_stack+0x11a/0x1b8)                
> 00: [ 9777.709624]  [<0000000005f7568e>] dump_stack+0x136/0x188                 
> 00: [ 9777.709641]  [<0000000005a16594>] print_address_description.isra.8+0x64/0
> 00: x3f0                                                                        
> 00: [ 9777.709657]  [<0000000005a16b6a>] __kasan_report+0x162/0x188             
> 00: [ 9777.709672]  [<00000000057779ce>] collect_percpu_times+0x2d6/0x798       
> 00: [ 9777.709687]  [<000000000577a10c>] psi_show+0x84/0x2b0                    
> 00: [ 9777.709703]  [<0000000005abf18c>] seq_read+0x2b4/0x838                   
> 00: [ 9777.709718]  [<0000000005a75502>] vfs_read+0x9a/0x158                    
> 00: [ 9777.709732]  [<0000000005a759ea>] ksys_read+0xea/0x190                   
> 00: [ 9777.709748]  [<0000000005fb3100>] system_call+0xd8/0x2b4                 
> 00: [ 9777.709759] INFO: lockdep is turned off.                                 
> 00: [ 9777.709769]                                                              
> 00: [ 9777.709778] The buggy address belongs to the page:                       
> 00: [ 9777.709793] page:000003d081988a40 refcount:0 mapcount:-2048 mapping:00000
> 00: 00000000000 index:0x0                                                       
> 00: [ 9777.709813] raw: 003fffc000000000 000003d081988a48 000003d081988a48 00000
> 00: 00000000000                                                                 
> 00: [ 9777.709831] raw: 0000000000000000 0000000000000000 fffff7ff00000000 00000
> 00: 00000000000                                                                 
> 00: [ 9777.710042] page dumped because: kasan: bad access detected              
> 00: [ 9777.710057] page_owner tracks the page as freed                          
> 00: [ 9777.710075] page last allocated via order 2, migratetype Unmovable, gfp_m
> 00: ask 0x52cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP)               
> 00: [ 9777.710145]  stack_trace_save+0xc2/0xd8                                  
> 00: [ 9777.710158]  register_dummy_stack+0x94/0xc0                              
> 00: [ 9777.710170]  init_page_owner+0x5c/0x518                                  
> 00: [ 9777.710188]  kernel_init_freeable+0x2a4/0x5a8                            
> 00: [ 9777.710199] page last free stack trace:                                  
> 00: [ 9777.710212]  stack_trace_save+0xc2/0xd8                                  
> 00: [ 9777.710224]  register_dummy_stack+0x94/0xc0                              
> 00: [ 9777.710236]  init_page_owner+0x5c/0x518                                  
> 00: [ 9777.710249]  kernel_init_freeable+0x2a4/0x5a8                            
> 00: [ 9777.710259]                                                              
> 00: [ 9777.710267] Memory state around the buggy address:                       
> 00: [ 9777.710282]  0000000066228f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc 
> 00: fc fc                                                                       
> 00: [ 9777.710297]  0000000066228f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc 
> 00: fc fc                                                                       
> 00: [ 9777.710312] >0000000066229000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
> 00: ff ff                                                                       
> 00: [ 9777.710325]                    ^                                         
> 00: [ 9777.710337]  0000000066229080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
> 00: ff ff                                                                       
> 00: [ 9777.710352]  0000000066229100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
> 00: ff ff                                                                       
> 00: [ 9777.710366] =============================================================
> 00: =====                                                                       
> 00: [ 9777.710389] Unable to handle kernel pointer dereference in virtual kernel
> 00:  address space                                                              
> 00: [ 9777.710580] Failing address: 0000000066229000 TEID: 0000000066229803     
> 00: [ 9777.710595] Fault in home space mode while using kernel ASCE.            
> 00: [ 9777.710613] AS:0000000007084007 R3:000000006dc28007 S:000000006d8fa800 P:
> 00: 000000006622943d                                                            
> 00: [ 9777.710700] Oops: 0011 ilc:2 [#1] SMP DEBUG_PAGEALLOC                    
> 00: [ 9777.710719] Modules linked in: brd ext4 crc16 mbcache jbd2 loop ip_tables
> 00:  x_tables xfs dasd_fba_mod dasd_eckd_mod dm_mirror dm_region_hash dm_log dm_
> 00: mod                                                                         
> 00: [ 9777.710778] CPU: 0 PID: 50240 Comm: read_all Tainted: G    B             
> 00: 5.4.0-rc7-next-20191118 #4                                                  
> 00: [ 9777.710794] Hardware name: IBM 2964 N96 400 (z/VM 6.4.0)                 
> 00: [ 9777.710806] Krnl PSW : 0704c00180000000 00000000057779ce (collect_percpu_
> 00: times+0x2d6/0x798)                                                          
> 00: [ 9777.710832]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:0 PM:0
> 00:  RI:0 EA:3                                                                  
> 00: [ 9777.710849] Krnl GPRS: 0000000000000001 000000004a8b2100 00000000063315ac
> 00:  0000000000000007                                                           
> 00: [ 9777.710865]            0000030000000000 000000000578e0be 0000000000000001
> 00:  000000003409fc70                                                           
> 00: [ 9777.710881]            000000000577a10c 070000003409fb00 0000000066229008
> 00:  0000000066229000                                                           
> 00: [ 9777.710896]            000000000639f6b0 0000000005ff5d30 00000000057779ce
> 00:  000000003409fa20                                                           
> 00: [ 9777.710939] Krnl Code: 00000000057779c0: ad031000            stosm   0(%r
> 00: 1),3                                                                        
> 00: [ 9777.710939]            00000000057779c4: b904002b            lgr     %r2,
> 00: %r11                                                                        
> 00: [ 9777.710939]           #00000000057779c8: c0e50014fc9c        brasl   %r14
> 00: ,0000000005a17300                                                           
> 00: [ 9777.710939]           >00000000057779ce: 5880b000            l       %r8,
> 00: 0(%r11)                                                                     
> 00: [ 9777.710939]            00000000057779d2: a7810001            tmll    %r8,
> 00: 1                                                                           
> 00: [ 9777.710939]            00000000057779d6: a784ff97            brc     8,00
> 00: 00000005777904                                                              
> 00: [ 9777.710939]            00000000057779da: a7f4ff8a            brc     15,0
> 00: 0000000057778ee                                                             
> 00: [ 9777.710939]            00000000057779de: e310f1300004        lg      %r1,
> 00: 304(%r15)                                                                   
> 00: [ 9777.711135] Call Trace:                                                  
> 00: [ 9777.711149] ([<00000000057779ce>] collect_percpu_times+0x2d6/0x798)      
> 00: [ 9777.711164]  [<000000000577a10c>] psi_show+0x84/0x2b0                    
> 00: [ 9777.711180]  [<0000000005abf18c>] seq_read+0x2b4/0x838                   
> 00: [ 9777.711194]  [<0000000005a75502>] vfs_read+0x9a/0x158                    
> 00: [ 9777.711207]  [<0000000005a759ea>] ksys_read+0xea/0x190                   
> 00: [ 9777.711222]  [<0000000005fb3100>] system_call+0xd8/0x2b4                 
> 00: [ 9777.711234] INFO: lockdep is turned off.                                 
> 00: [ 9777.711244] Last Breaking-Event-Address:                                 
> 00: [ 9777.711257]  [<0000000005a16a70>] __kasan_report+0x68/0x188              
> 00: [ 9777.711273] Kernel panic - not syncing: Fatal exception: panic_on_oops
