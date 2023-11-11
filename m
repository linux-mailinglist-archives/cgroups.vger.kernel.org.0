Return-Path: <cgroups+bounces-332-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F143B7E88C4
	for <lists+cgroups@lfdr.de>; Sat, 11 Nov 2023 04:06:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7CBC281248
	for <lists+cgroups@lfdr.de>; Sat, 11 Nov 2023 03:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174935399;
	Sat, 11 Nov 2023 03:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rb/Moxm7"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506211860;
	Sat, 11 Nov 2023 03:05:55 +0000 (UTC)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55DB13C0E;
	Fri, 10 Nov 2023 19:05:53 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6b709048f32so2470715b3a.0;
        Fri, 10 Nov 2023 19:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699671953; x=1700276753; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VfzDqMYQmBmjq9uvQPvzGmUJyL/1vfZVHtCKJYCOiuY=;
        b=Rb/Moxm74+x3yyloFnMQ39EYD4UJenHpu5Wc0imovTMmE6GLmQJYj3iJMeG7N4GP5q
         dMSGk4PJKoLRWqW8sgfqTEIh/NGlwJROE73i23y1fO1Dmhf2i7NQIS9PqPlY7lvkvwol
         g7bY8yeqOAtJf26McY1oILT+L/EiCis2KocW/oxRPfArJZM3A9CecuzTqeBf+DnezcLR
         7VMzpGwEWaDNmxlj28idTOagKaO4TVkDisGJE9fCP3gPJ3JJ4BrX4rB64Wwz9RamVuXk
         m21yJ7c5Nf9XK/w3KcFc1vVl7Yv9kViweMjJ+UOhk13soNPmcTQKv1l/QBMNkm5Ewrg5
         +CTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699671953; x=1700276753;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VfzDqMYQmBmjq9uvQPvzGmUJyL/1vfZVHtCKJYCOiuY=;
        b=m2Vm3v1B5H0m5brU6EKLt/+Eyg07QO0nZ9mcch1n2u0aNpYtcresqgXtjMVEGR7CLy
         qQudddldasQlXQC67tqnWS1yAHk882DsSnXTvhhJ4xXbflNxNShokoJXK51uiBLIzALM
         zK/pqJ/NwBLKIJku2QZdt92aIJ2PpruVzXZFe/nnO4o4piLDDXwv4YSU/TGUI9ECEjDt
         tfe/slbU7Nf+FlwHrxMYnVSkeH2Y2G/4A2mjvQ0IxmsI+8aiKB6BKtR8PtaHkEYPRciT
         wiZn3xK5kHHZdcCyyTxecBjXTZUuYbuLrB5m1SbxFjAjJQ8qIQPZK2n+fMGfwFqLLxBL
         JJtw==
X-Gm-Message-State: AOJu0YyT3JVNqT22GttOxuFNWuLX44cPwE9na66jQcLC2FesJB8k4XIO
	99eIkDSvJcISKfT106fkyhY=
X-Google-Smtp-Source: AGHT+IHUPJgHMXEV/EyUFO/yC9XqxCh/1abXVk25+sGMhpTAXc5HF4ljKpw3s0KUaXLtUJycmLQLcw==
X-Received: by 2002:a05:6a00:98c:b0:6c0:3e5e:1d46 with SMTP id u12-20020a056a00098c00b006c03e5e1d46mr939728pfg.21.1699671952669;
        Fri, 10 Nov 2023 19:05:52 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::4:7384])
        by smtp.gmail.com with ESMTPSA id ei23-20020a056a0080d700b006b5922221f4sm422487pfb.8.2023.11.10.19.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 19:05:52 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 10 Nov 2023 17:05:50 -1000
From: "tj@kernel.org" <tj@kernel.org>
To: Gregory Price <gregory.price@memverge.com>
Cc: John Groves <john@jagalactic.com>,
	Gregory Price <gourry.memverge@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"ying.huang@intel.com" <ying.huang@intel.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"mhocko@kernel.org" <mhocko@kernel.org>,
	"lizefan.x@bytedance.com" <lizefan.x@bytedance.com>,
	"hannes@cmpxchg.org" <hannes@cmpxchg.org>,
	"corbet@lwn.net" <corbet@lwn.net>,
	"roman.gushchin@linux.dev" <roman.gushchin@linux.dev>,
	"shakeelb@google.com" <shakeelb@google.com>,
	"muchun.song@linux.dev" <muchun.song@linux.dev>,
	"jgroves@micron.com" <jgroves@micron.com>
Subject: Re: [RFC PATCH v4 0/3] memcg weighted interleave mempolicy control
Message-ID: <ZU7vjsSkGbRLza-K@slm.duckdns.org>
References: <20231109002517.106829-1-gregory.price@memverge.com>
 <klhcqksrg7uvdrf6hoi5tegifycjltz2kx2d62hapmw3ulr7oa@woibsnrpgox4>
 <0100018bb64636ef-9daaf0c0-813c-4209-94e4-96ba6854f554-000000@email.amazonses.com>
 <ZU6pR46kiuzPricM@slm.duckdns.org>
 <ZU6uxSrj75EiXise@memverge.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZU6uxSrj75EiXise@memverge.com>

Hello, Gregory.

On Fri, Nov 10, 2023 at 05:29:25PM -0500, Gregory Price wrote:
> I did originally implement it this way, but note that it will either
> require some creative extension of set_mempolicy or even set_mempolicy2
> as proposed here:
> 
> https://lore.kernel.org/all/20231003002156.740595-1-gregory.price@memverge.com/
> 
> One of the problems to consider is task migration.  If a task is
> migrated from one socket to another, for example by being moved to a new
> cgroup with a different cpuset - the weights might be completely nonsensical
> for the new allowed topology.
> 
> Unfortunately mpol has no way of being changed from outside the task
> itself once it's applied, other than changing its nodemasks via cpusets.

Maybe it's time to add one?

> So one concrete use case: kubernetes might like change cpusets or move
> tasks from one cgroup to another, or a vm might be migrated from one set
> of nodes to enother (technically not mutually exclusive here).  Some
> memory policy settings (like weights) may no longer apply when this
> happens, so it would be preferable to have a way to change them.

Neither covers all use cases. As you noted in your mempolicy message, if the
application wants finer grained control, cgroup interface isn't great. In
general, any changes which are dynamically initiated by the application
itself isn't a great fit for cgroup.

I'm generally pretty awry of adding non-resource group configuration
interface especially when they don't have counter part in the regular
per-process/thread API for a few reasons:

1. The reason why people try to add those through cgroup somtimes is because
   it seems easier to add those new features through cgroup, which may be
   true to some degree, but shortcuts often aren't very conducive to long
   term maintainability.

2. As noted above, just having cgroup often excludes a signficant portion of
   use cases. Not all systems enable cgroups and programatic accesses from
   target processes / threads are coarse-grained and can be really awakward.

3. Cgroup can be convenient when group config change is necessary. However,
   we really don't want to keep adding kernel interface just for changing
   configs for a group of threads. For config changes which aren't high
   frequency, userspace iterating the member processes and applying the
   changes if possible is usually good enough which usually involves looping
   until no new process is found. If the looping is problematic, cgroup
   freezer can be used to atomically stop all member threads to provide
   atomicity too.

Thanks.

-- 
tejun

