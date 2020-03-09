Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89A6717DC5B
	for <lists+cgroups@lfdr.de>; Mon,  9 Mar 2020 10:24:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725956AbgCIJY2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 9 Mar 2020 05:24:28 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34029 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbgCIJY2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 9 Mar 2020 05:24:28 -0400
Received: by mail-lj1-f194.google.com with SMTP id j19so9135168lji.1
        for <cgroups@vger.kernel.org>; Mon, 09 Mar 2020 02:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YQ8ihxTiV/jjqWVrSKRrrI0iYYsvH3N8HGqyTw+Ycoo=;
        b=XhADhYlmynisFq92OzBfjdzZBO1qZW/KeHGDyUWlY2oH5uNbf72oBV0Gs3LNR2sAVG
         l0z42Y2GXAdOWKhvwAMNEKiTPdgGzluQLnp/vHaj9ZGqUP0E2KhFlGn+No+MXizHRmiy
         6DRznZKEo3ZSIQhv+bhpzfVcuJNd/IrfihsBLgHg2hrQ52G2glIjAWSwGgczU3L6AUnQ
         u+N3LtlsG3R67i+DjaC47I6m06YGZdlQhpTbbLlLPcWZ2NqYdGKOFpbPXoFUzLi9MT7U
         dlo84YXkjmcRI4OhHuofBD1nuaAt+D9Zht/0lpexO+xQ/iFnkHuQ1DAbbrjduFKHb00A
         /OYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YQ8ihxTiV/jjqWVrSKRrrI0iYYsvH3N8HGqyTw+Ycoo=;
        b=gO9OOamkzWyEGPp3wJscmBclVYSwsVzjz7f3bbf3IpSdNkOrBBrYHXs2Y6HGujchGl
         Wda2/3nmWetC29eYUGUENv8lHZVh/oTuzldkzV//wTrA7/XMQpkQsFRZW56r2F2dLD+B
         51754yJ26kAe36eGUQFH2LG3/emSWNLnfMZo2vVo5pFGC8S7Y1wYT3/nkOJ6FDIdPQ3m
         /wjvfDxi1hrB+kXY3sRfwHLKxtzkZRozcdl4Fz1RrD+f96PHKfdy863WI4eQjlV2BWO8
         q32LZwk/sAk3NQPV6C71H6iH+aAymBTlr/1CwTLHOUdOOxez4uknKgieFXJzU0x9lJAp
         bOzg==
X-Gm-Message-State: ANhLgQ1cLpdX84fCW06KlLWik1bj0kBlvSrADCwNGvExBDI9bBhc8UTE
        PfPd3EM7EBo2+e9o/vrAcpZblg==
X-Google-Smtp-Source: ADFU+vvxLcx07yy2z4SiJN1Y1h8zgf7mZMks/EH/eMARLBfm6P38Bhh2wv6ZOqosSgOadfUL30Qq9g==
X-Received: by 2002:a2e:5304:: with SMTP id h4mr9009259ljb.75.1583745865154;
        Mon, 09 Mar 2020 02:24:25 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id b17sm21888957ljd.5.2020.03.09.02.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 02:24:24 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id D3A3D10258B; Mon,  9 Mar 2020 12:24:23 +0300 (+03)
Date:   Mon, 9 Mar 2020 12:24:23 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     syzbot <syzbot+826543256ed3b8c37f62@syzkaller.appspotmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, cgroups@vger.kernel.org,
        hannes@cmpxchg.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mhocko@kernel.org,
        syzkaller-bugs@googlegroups.com, vdavydov.dev@gmail.com
Subject: Re: linux-next test error: BUG: using __this_cpu_read() in
 preemptible code in __mod_memcg_state
Message-ID: <20200309092423.2ww3aw6yfyce7yty@box>
References: <00000000000022640205a04a20d8@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000022640205a04a20d8@google.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Mar 07, 2020 at 01:05:10PM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    b86a6a24 Add linux-next specific files for 20200306
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=1766b731e00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=9c79dccc623ccc6f
> dashboard link: https://syzkaller.appspot.com/bug?extid=826543256ed3b8c37f62
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> 
> Unfortunately, I don't have any reproducer for this crash yet.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+826543256ed3b8c37f62@syzkaller.appspotmail.com
> 
> check_preemption_disabled: 3 callbacks suppressed
> BUG: using __this_cpu_read() in preemptible [00000000] code: syz-fuzzer/9432
> caller is __mod_memcg_state+0x27/0x1a0 mm/memcontrol.c:689
> CPU: 1 PID: 9432 Comm: syz-fuzzer Not tainted 5.6.0-rc4-next-20200306-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x188/0x20d lib/dump_stack.c:118
>  check_preemption_disabled lib/smp_processor_id.c:47 [inline]
>  __this_cpu_preempt_check.cold+0x84/0x90 lib/smp_processor_id.c:64
>  __mod_memcg_state+0x27/0x1a0 mm/memcontrol.c:689
>  __split_huge_page mm/huge_memory.c:2575 [inline]
>  split_huge_page_to_list+0x124b/0x3380 mm/huge_memory.c:2862
>  split_huge_page include/linux/huge_mm.h:167 [inline]

It looks like a regression due to c8cba0cc2a80 ("mm/thp: narrow lru
locking").

Alex?

>  madvise_free_huge_pmd+0x873/0xb90 mm/huge_memory.c:1766
>  madvise_free_pte_range+0x6ff/0x2650 mm/madvise.c:584
>  walk_pmd_range mm/pagewalk.c:89 [inline]
>  walk_pud_range mm/pagewalk.c:160 [inline]
>  walk_p4d_range mm/pagewalk.c:193 [inline]
>  walk_pgd_range mm/pagewalk.c:229 [inline]
>  __walk_page_range+0xcfb/0x2070 mm/pagewalk.c:331
>  walk_page_range+0x1bd/0x3a0 mm/pagewalk.c:427
>  madvise_free_single_vma+0x384/0x550 mm/madvise.c:731
>  madvise_dontneed_free mm/madvise.c:819 [inline]
>  madvise_vma mm/madvise.c:958 [inline]
>  do_madvise mm/madvise.c:1161 [inline]
>  do_madvise+0x5ba/0x1b80 mm/madvise.c:1084
>  __do_sys_madvise mm/madvise.c:1189 [inline]
>  __se_sys_madvise mm/madvise.c:1187 [inline]
>  __x64_sys_madvise+0xae/0x120 mm/madvise.c:1187
>  do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x460bf7
-- 
 Kirill A. Shutemov
