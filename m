Return-Path: <cgroups+bounces-902-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 749798095FA
	for <lists+cgroups@lfdr.de>; Thu,  7 Dec 2023 23:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C7A31F21336
	for <lists+cgroups@lfdr.de>; Thu,  7 Dec 2023 22:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075CC57309;
	Thu,  7 Dec 2023 22:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QMeMDDbA"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D471ED5B;
	Thu,  7 Dec 2023 14:56:41 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1d06819a9cbso11664505ad.1;
        Thu, 07 Dec 2023 14:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701989801; x=1702594601; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=En3Kfr6yFcketU+H68sFxgGmFIYcncOOAldDpFCnChY=;
        b=QMeMDDbAP88WWhVuuN5aeic6WA1UpuRXPiaU8foCuGOyzC4iupY6l/MEGyRmiQaWU3
         TaSbuaWvuaAV1HwMrUXcc4aljpw9C5zcX4UnyF/Yic/GWAWsY62bIe/WllYBfFORn7jq
         Fj1VzcNojyOGBWMWaxAjTFEKrLcFV+BUrApCjrBPXnwAZaIqnZ8sG67Facwty4kMj/7R
         E3AAu26wxaVnRhP8lYEe/aC23l1X1B4T+anE8KeDcAbSbWw2FAl4VtNUig+55y8wcHnP
         MGFkZUycq4/QePBkUQ+KtQ344RWipaxY+ysU9U5lQgzfKAzqsrRL2Zvlbw6QGnU35nBF
         KDKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701989801; x=1702594601;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=En3Kfr6yFcketU+H68sFxgGmFIYcncOOAldDpFCnChY=;
        b=mcOAoWXC/pONZC96KfXkmJylfGBxZMTMbthMbZ/epp9jpdxrcrbSyI6rTQZaqMS5Te
         EN2P3RRlhFRncqow1ryFVEyVc7lmQklaphorsrBNuzZ4x/xpKArKSMBkWP6oh4Ceu2kG
         tD963lUQlU1D1TBYRJKKWw8Bnw6YjCRmXfT2Mf4eOyrdJr1lRqC/4X66bRhQ4ZX7CyMg
         zgT90iE4ICGypHHnGWFZacZGHi7LtAbLZ0pNHn0em+dyD8+MxCiRZqzSP2R07iC1v7Gy
         jRM0sJpcMw48ezXT5jUYuXWtxcUYrMHXVrKlzD8G4VZCFp8dOlZaHw/7+oVndOI2Iboo
         pgmA==
X-Gm-Message-State: AOJu0YxDmw2KKUI8G0XkyHrL7b2oxIryYas12pob7X+Y0i1anUJUtVkS
	Zds1Juc9hTLLcs4+qrmMf1eTLA4LcGg=
X-Google-Smtp-Source: AGHT+IFGA30PwUqkquKHLYpKyg/lGbgTctk149l/c1J4fi6WKId3oOAEZApvA7unUMZX6zJGcM2Glw==
X-Received: by 2002:a17:902:be14:b0:1d0:6ffd:adf1 with SMTP id r20-20020a170902be1400b001d06ffdadf1mr2650460pls.88.1701989800194;
        Thu, 07 Dec 2023 14:56:40 -0800 (PST)
Received: from localhost (dhcp-72-253-202-210.hawaiiantel.net. [72.253.202.210])
        by smtp.gmail.com with ESMTPSA id t1-20020a170902b20100b001bb9d6b1baasm330392plr.198.2023.12.07.14.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 14:56:39 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 7 Dec 2023 12:56:38 -1000
From: Tejun Heo <tj@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Yafang Shao <laoar.shao@gmail.com>, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Yosry Ahmed <yosryahmed@google.com>
Subject: Re: [PATCH-cgroup v2] cgroup: Move rcu_head up near the top of
 cgroup_root
Message-ID: <ZXJNpr2uGEcxpoQt@slm.duckdns.org>
References: <20231207134614.882991-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207134614.882991-1-longman@redhat.com>

On Thu, Dec 07, 2023 at 08:46:14AM -0500, Waiman Long wrote:
> Commit d23b5c577715 ("cgroup: Make operations on the cgroup root_list RCU
> safe") adds a new rcu_head to the cgroup_root structure and kvfree_rcu()
> for freeing the cgroup_root.
> 
> The current implementation of kvfree_rcu(), however, has the limitation
> that the offset of the rcu_head structure within the larger data
> structure must be less than 4096 or the compilation will fail. See the
> macro definition of __is_kvfree_rcu_offset() in include/linux/rcupdate.h
> for more information.
> 
> By putting rcu_head below the large cgroup structure, any change to the
> cgroup structure that makes it larger run the risk of causing build
> failure under certain configurations. Commit 77070eeb8821 ("cgroup:
> Avoid false cacheline sharing of read mostly rstat_cpu") happens to be
> the last straw that breaks it. Fix this problem by moving the rcu_head
> structure up before the cgroup structure.
> 
> Fixes: d23b5c577715 ("cgroup: Make operations on the cgroup root_list RCU safe")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Closes: https://lore.kernel.org/lkml/20231207143806.114e0a74@canb.auug.org.au/
> Signed-off-by: Waiman Long <longman@redhat.com>
> Acked-by: Yafang Shao <laoar.shao@gmail.com>

Applied to cgroup/for-6.8.

Thanks.

-- 
tejun

