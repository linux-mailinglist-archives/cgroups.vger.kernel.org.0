Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43B9E7BE670
	for <lists+cgroups@lfdr.de>; Mon,  9 Oct 2023 18:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376275AbjJIQcp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 9 Oct 2023 12:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376996AbjJIQcp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 9 Oct 2023 12:32:45 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0244B99;
        Mon,  9 Oct 2023 09:32:41 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-692b2bdfce9so4199310b3a.3;
        Mon, 09 Oct 2023 09:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696869161; x=1697473961; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XJi9g5vhdLwURSXZ5rbB+GYLCNUR65SA5UMRdk3tZlo=;
        b=QuMD16oBOlsB/HuurZeT1UEGjzuy8jKlk66zyLl/8MTsXYqWlg1Iw/FCxMHCBZ601T
         6Mo/qPVq0XeU6GPwBkxbITB1aStImAdIvAKDIYLZbxnV3kV1bHX5NtQhEPN51ek3R+fm
         R+TBQLyEysPa/rzBH7pAyqBWL+jAhhENoxH8DPLjao3TWNCBSTnN/kRGGRXYOYyQzNg4
         TuWAwxaVCnegYZPJwsy0KvzTMwAc2bCd7C5LGaZj27Emvis2pqE2QaMAz3JLpi1VNIqW
         4niLLaDZTSYdIZevCwePa6aMszvnC0FA/kSdC+pt2uGy3QvhZvKeHfkMMHZJoR2YdNlE
         wrUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696869161; x=1697473961;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XJi9g5vhdLwURSXZ5rbB+GYLCNUR65SA5UMRdk3tZlo=;
        b=T8EpGMIPb1BtKna+o4Nve+w7EutBmlVrtXW0e4tLyd3N103iVa9NbToMI0ydNRmjED
         x9NU1/tNMCN6TsQ6wL4C7P7JVJDUyXISVgy60s4H/sHVNlONgGbgQ1seX56i0xHoujA4
         ACL9ZKWWjmRGOmMYlUbwOAYu2/5+h+0nS8QpV5WwJlOJ47df+JzVhSA05xxCZg0tzrDU
         1o/Yg2tW/RZSlvuNEssql244CcKMRGu1Yx224Xir43Han+kFoRrwDsKLfuHRzO+EJgI8
         Ul5IIfjYG+Bf8KVH8/lotLh1JhexMb86EHySV0JQkxN13pATMkaEukCpjKhaq3w3a2tK
         CjKA==
X-Gm-Message-State: AOJu0Yxh1YpuezOrb3vIDHxxlW57v6nDqu2MNPBWnBh3zT0ZHoR6s0t8
        agWg7nIN+DJPxvZKQwpDjhk=
X-Google-Smtp-Source: AGHT+IHmta4PcsgmrOKD/IGlyysSdzdB4QIDGRKbb2CT5TDOLfeVle/ZEpC0LhWBSgYb9P6UHBQF4Q==
X-Received: by 2002:a05:6a20:8e2a:b0:154:a1e4:b676 with SMTP id y42-20020a056a208e2a00b00154a1e4b676mr20841756pzj.4.1696869161295;
        Mon, 09 Oct 2023 09:32:41 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:cced])
        by smtp.gmail.com with ESMTPSA id o22-20020a056a001b5600b00692aea7fb29sm6634688pfv.88.2023.10.09.09.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 09:32:39 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 9 Oct 2023 06:32:38 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Firo Yang <firo.yang@suse.com>
Subject: Re: [PATCH] cgroup: Remove duplicates in cgroup v1 tasks file
Message-ID: <ZSQrJtNAw9K4nNiG@slm.duckdns.org>
References: <20231009135811.2627-1-mkoutny@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231009135811.2627-1-mkoutny@suse.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Oct 09, 2023 at 03:58:11PM +0200, Michal Koutný wrote:
> One PID may appear multiple times in a preloaded pidlist.
> (Possibly due to PID recycling but we have reports of the same
> task_struct appearing with different PIDs, thus possibly involving
> transfer of PID via de_thread().)
> 
> Because v1 seq_file iterator uses PIDs as position, it leads to
> a message:
> > seq_file: buggy .next function kernfs_seq_next did not update position index
> 
> Conservative and quick fix consists of removing duplicates from `tasks`
> file (as opposed to removing pidlists altogether). It doesn't affect
> correctness (it's sufficient to show a PID once), performance impact
> would be hidden by unconditional sorting of the pidlist already in place
> (asymptotically).
> 
> Link: https://lore.kernel.org/r/20230823174804.23632-1-mkoutny@suse.com/
> Suggested-by: Firo Yang <firo.yang@suse.com>
> Signed-off-by: Michal Koutný <mkoutny@suse.com>

Applied to cgroup/for-6.6-fixes.

Thanks.

-- 
tejun
