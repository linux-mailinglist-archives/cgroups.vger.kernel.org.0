Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE285AC637
	for <lists+cgroups@lfdr.de>; Sun,  4 Sep 2022 21:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbiIDTmU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 4 Sep 2022 15:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbiIDTmT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 4 Sep 2022 15:42:19 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12DE12C64C;
        Sun,  4 Sep 2022 12:42:17 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id x23so6663160pll.7;
        Sun, 04 Sep 2022 12:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=f6y6RxJIYsgqs5sNLTn4Q3lZDib3LF1nipty1Lvv/4o=;
        b=Mga6r3qCMXMLYKA2zTcaYD3QN6xJBj3aaSKs0buxConQZ1B6lPPzqk5xmwDbuZVxkJ
         DMcSRs9ugt2FJ8neiNn6Q53KhDker+chdZV8Wg+N9hgvDYSL0xtt2UWVuj1hasFcyBT5
         O6e4d+6UwQ+k3S58tcktgIesJzoVb1FfakKT/6PT1kGSPFl0PurKXyjz6c8aYQGq/7r+
         uu9devDAYW6+5VXE7ytS1debDyOuzIqysQcPS7159aczGKjxML3HijsqUav+VoSSwEhd
         qrp9Kd17/yyj1hUCtXkY/S81Kf4JBTKBtljSdiQM6iH7mulFTMohQkikplbmC+GaGQxo
         PtnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=f6y6RxJIYsgqs5sNLTn4Q3lZDib3LF1nipty1Lvv/4o=;
        b=RNQ7Ts7OhHJIMffnRQp1gG/wEGU01vEeb0XfviKsuSIGlKPgDfelS9E+a2X1+dMM9s
         duDddYNj1685MBJ9YowCB1XoYBIERxcSMYChoEvB7JbpIJNAL+go9DeL+doZnt6sRGQx
         V9zwg2ZHVQP3eW66E8xjNSznecJpfxwrCaSNAmvuAL2XmHMBhs7fuK1pD5hb9MxRvYyC
         WJiK0Xr0xhMrtM4sq4ZxYaIwRLFUAP/4L4cjJP8MTVFQW/gYzA+ZvowyTJN6rTuCEvYh
         G16wCa8xM8Ll9R40Hix7QL61JhdPUA2BzOY770jei4WjCWS0PuSeacOA1Viv6VVdxv/0
         pArA==
X-Gm-Message-State: ACgBeo0H1i2ousihLkDpA/M3YMJfwIMKgoNAKXlO+mhb7QLA9ySdior2
        Uye2bebeRedqGibfSsYaesXMDlkRIWE=
X-Google-Smtp-Source: AA6agR5xDvfZ9YWB80pcvSsMEsJ0ydv70KbFmhlGRYcjpD1j92TomVjymRMdJh18iqiK+QHxfHS00A==
X-Received: by 2002:a17:902:da91:b0:176:860a:7725 with SMTP id j17-20020a170902da9100b00176860a7725mr7875917plx.60.1662320536421;
        Sun, 04 Sep 2022 12:42:16 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:291b])
        by smtp.gmail.com with ESMTPSA id h2-20020a17090a130200b002006f15ad4fsm152347pja.10.2022.09.04.12.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 12:42:15 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Sun, 4 Sep 2022 09:42:14 -1000
From:   Tejun Heo <tj@kernel.org>
To:     hezhongkun <hezhongkun.hzk@bytedance.com>
Cc:     lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup/cpuset: Add a new isolated mems.policy type.
Message-ID: <YxT/liaotbiOod51@slm.duckdns.org>
References: <20220902063303.1057-1-hezhongkun.hzk@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220902063303.1057-1-hezhongkun.hzk@bytedance.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Fri, Sep 02, 2022 at 02:33:03PM +0800, hezhongkun wrote:
> From: Zhongkun He <hezhongkun.hzk@bytedance.com>
> 
> Mempolicy is difficult to use because it is set in-process
> via a system call. We want to make it easier to use mempolicy
> in cpuset, and  we can control low-priority cgroups to
> allocate memory in specified nodes. So this patch want to
> adds the mempolicy interface in cpuset.
> 
> The mempolicy priority of cpuset is lower than the task.
> The order of getting the policy is:
> 	1) vma mempolicy
> 	2) task->mempolicy
> 	3) cpuset->mempolicy
> 	4) default policy.
> 
> cpuset's policy is owned by itself, but descendants will
> get the default mempolicy from parent.
> 
> How to use the mempolicy interface:
> 	echo prefer:2 > /sys/fs/cgroup/zz/cpuset.mems.policy
> 	echo bind:1-3 > /sys/fs/cgroup/zz/cpuset.mems.policy
>         echo interleave:0,1,2,3 >/sys/fs/cgroup/zz/cpuset.mems.policy
> Show the policy:
> 	cat /sys/fs/cgroup/zz/cpuset.mems.policy
> 		prefer:2
> 	cat /sys/fs/cgroup/zz/cpuset.mems.policy
> 		bind:1-3
> 	cat /sys/fs/cgroup/zz/cpuset.mems.policy
> 		interleave:0-3
> Clear the policy:
> 	echo default > /sys/fs/cgroup/zz/cpuset.mems.policy

So, I'm a fan of adding cgroup functionalities which don't enforce anything
resource related. What you're proposing can easily be achieved with userland
tooling, right?

Thanks.

-- 
tejun
