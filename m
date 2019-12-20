Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1092E127A16
	for <lists+cgroups@lfdr.de>; Fri, 20 Dec 2019 12:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbfLTLht (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 20 Dec 2019 06:37:49 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53923 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727184AbfLTLht (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 20 Dec 2019 06:37:49 -0500
Received: by mail-wm1-f68.google.com with SMTP id m24so8595226wmc.3;
        Fri, 20 Dec 2019 03:37:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=+xqrG/Fr+lk5K0m1pptDnTQOO1AdoG749ulUXApgoJo=;
        b=PjsD4G79liFs7IK7ZIxgjW2sIjJcOIfF+7D7HWaxyXYhsvxdmoVfdm6JcF9Nx73Z1R
         TyohPsE7Cu/VZJ6zF2X2we0ZT2jojRde9jJfztrNF1L9GVPHyFe3RYwUudRcgyekELW7
         WWXZIM1jZeqvL8Yy6TCLojYuNcVEnswyssEMe20oFdgX42rcvIczqRv9XBzTHRxT83u5
         hhIWjkdJM2TGxu0+lr6k7jao1sKPUuH89boBbj0Xkz65zGTtkIfasMH1zfZFFOYiPnhr
         OoDuK7ugzv4yViuSre3YsmfCaAtgKUuU6yhXNxzqdhXHOoPZtudqwCZgY5BTrZQvfn/u
         qm4w==
X-Gm-Message-State: APjAAAVe85pwyqnDUtNdqIXch42djNI2d3K2fmoy/mJ61rsZto6pDFNk
        HUWg7i/y0H0UrHFADaryFlc=
X-Google-Smtp-Source: APXvYqxea3sQYL0zemf/BDfh/Fngl+lzOAoLU0x312PESG6f2yo0GmWBhUf3frSoVwbx7/PQps66Kg==
X-Received: by 2002:a1c:638a:: with SMTP id x132mr16983341wmb.43.1576841866625;
        Fri, 20 Dec 2019 03:37:46 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id f1sm9955905wrp.93.2019.12.20.03.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 03:37:45 -0800 (PST)
Date:   Fri, 20 Dec 2019 12:37:44 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     =?utf-8?B?5b2t5b+X5Yia?= <zgpeng.linux@gmail.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org,
        vdavydov.dev@gmail.com, Shakeel Butt <shakeelb@google.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, zgpeng <zgpeng@tencent.com>
Subject: Re: [PATCH] oom: choose a more suitable process to kill while all
 processes are not killable
Message-ID: <20191220113744.GF20332@dhcp22.suse.cz>
References: <1576823172-25943-1-git-send-email-zgpeng.linux@gmail.com>
 <20191220071334.GB20332@dhcp22.suse.cz>
 <CAE5vP3mHjdM-PwjUURwXgZDfgQ0b2BbgHkWZCHe-ysSmZ58pFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE5vP3mHjdM-PwjUURwXgZDfgQ0b2BbgHkWZCHe-ysSmZ58pFw@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

[Please do not top post]

On Fri 20-12-19 17:56:20, 彭志刚 wrote:
> certainly.
> 
> Steps to reproduce:
> (1)Create a mm cgroup and set memory.limit_in_bytes
> (2)Move the bash process to the newly created cgroup, and set the
> oom_score_adj of the  bash process to -998.
> (3)In bash, start multiple processes, each process consumes different
> memory until cgroup oom is triggered.
> 
> The triggered phenomenon is shown below. We can see that when cgroup oom
> happened, process 23777 was killed, but in fact, 23772 consumes more memory;
> 
> [  591.000970] Tasks state (memory values in pages):
> [  591.000970] [  pid  ]   uid  tgid total_vm      rss pgtables_bytes swapents oom_score_adj name
> [  591.000973] [  23344]     0 23344     2863      923    61440        0        -998 bash
> [  591.000975] [  23714]     0 23714    27522    25935   258048        0        -998 test
> [  591.000976] [  23772]     0 23772   104622   103032   876544        0        -998 test

points = 103032 + 0 + 876544/4096 = 103246

> [  591.000978] [  23777]     0 23777    78922    77335   667648        0        -998 test

points = 77335 + 0 + 667648/4096 = 77498

It is not clear what is the actual hard limit but let's assume that
rss+page_tables is the only charged memory (or at least the majority of
it). That would be 207680 so the normalized oom_score_adj would be
-206586 which is way too big for both tasks so from the OOM killer
perspective both tasks are equal.

The question is whether this is a bug or a (mis)feature. The
oom_score_adj je documented as follows:
Documentation/filesystems/proc.txt
: Consequently, it is very simple for userspace to define the amount of memory to
: consider for each task.  Setting a /proc/<pid>/oom_score_adj value of +500, for
: example, is roughly equivalent to allowing the remainder of tasks sharing the
: same system, cpuset, mempolicy, or memory controller resources to use at least
: 50% more memory.  A value of -500, on the other hand, would be roughly
: equivalent to discounting 50% of the task's allowed memory from being considered
: as scoring against the task.

Which implies that we are talking about the budget based on a usable
memory (aka hard limit in this case). I do agree that the semantic is
awkward. I know there are usecases which try to use the existing scheme
for oom_score_adj to fine tune oom decisions and I am worried your patch
might break those.

That being said, I am not sure this change is safe wrt. to backward
compatibility. I would rather recommend to not using oom_score_adj for
anything but OOM_SCORE_ADJ_MIN resp OOM_SCORE_ADJ_MAX.
-- 
Michal Hocko
SUSE Labs
