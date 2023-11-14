Return-Path: <cgroups+bounces-409-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 076297EB479
	for <lists+cgroups@lfdr.de>; Tue, 14 Nov 2023 17:08:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2206D1C20A02
	for <lists+cgroups@lfdr.de>; Tue, 14 Nov 2023 16:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9512541A8F;
	Tue, 14 Nov 2023 16:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M/D2i1NN"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FED4177C
	for <cgroups@vger.kernel.org>; Tue, 14 Nov 2023 16:08:21 +0000 (UTC)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2709413D
	for <cgroups@vger.kernel.org>; Tue, 14 Nov 2023 08:08:17 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6b709048d8eso5144356b3a.2
        for <cgroups@vger.kernel.org>; Tue, 14 Nov 2023 08:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699978096; x=1700582896; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oRY/n4hzMG96K6ti5fJKDmZ79xgR3kVdqHaH6UD7r9k=;
        b=M/D2i1NNjakgUfAu6iiIs1jgFzTctDXSpqS34AOWVeOknum5x6I0YC3BGbpsptDIJQ
         qmL2BgTPM7vZXMcWiBxMzy1kvp/bXHA+ASo3P2OT+4c5tMim7BdO9clwW7+pW7ns2Nhr
         pAFtH3u7JLbmx5pO3dJhl8U+ICaPB7gL7FEpw0w90uai7rpnxYu4wopn2N9s0IjOgDSo
         MUX1Mo+EKn0TA3HyvZpw+4+8DP9fxFRsG6Dfv27GKRd7j8DqL1BMyKILYb0drA/45c16
         IE2E20tCtI0VDOQrFIizRRQEIQbQm3pcnkoOETbM6Jzs87lZ+V+6XVfOkLeyeJZ6XygR
         MgqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699978096; x=1700582896;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oRY/n4hzMG96K6ti5fJKDmZ79xgR3kVdqHaH6UD7r9k=;
        b=wGoJVLKMdcJHOkT5HUADX2c5TrNF3+q4laCGGnEItPHxYwrp0fK9jOcL+uD5CzrlZE
         XmVJy4VOmbxMqpmbWfUnvaVZmwHmgA46ZGT6N2T09oeHar3aOU6rLEA8k4ZNJWhKudpz
         JSGumKxiAcEzjG1Al90vWZREN/aGvbsWkjB5+n00i+zhZ3I8HNArb3hJS+cHf5ksHcq5
         13U7uI9yE6rCUtMT7VEJfiTJuszqR9IqIZa0HKuN9aw7YPxdFAVg/4lUTvSDcpTGqdKe
         k4J9yx6tCy+/9TGT/VKnigUE06z8WwUUjTjAsTNnyYGZxMEMMQcDrzM6hp8CTCwdDKwP
         61eg==
X-Gm-Message-State: AOJu0YwkxnP9fGk8v+Be4aqAUXyJMfRy+24bkrW0BuNsCq6PlGrg51Ub
	kpX+svXRl13Zm5XdETua2o8=
X-Google-Smtp-Source: AGHT+IEkK972CS9pzizdXfIYPWa+S6AHbSONE2KWS5E24UpeYFVdNsFAdaXxkYFzYh3o+OIOgOBagg==
X-Received: by 2002:a05:6a00:8c05:b0:6c3:402a:d53d with SMTP id ih5-20020a056a008c0500b006c3402ad53dmr8519243pfb.2.1699978096521;
        Tue, 14 Nov 2023 08:08:16 -0800 (PST)
Received: from localhost (dhcp-72-253-202-210.hawaiiantel.net. [72.253.202.210])
        by smtp.gmail.com with ESMTPSA id t8-20020a62ea08000000b006c34274f66asm1315982pfh.102.2023.11.14.08.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 08:08:16 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 14 Nov 2023 06:08:14 -1000
From: Tejun Heo <tj@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: cgroups@vger.kernel.org, Waiman Long <longman@redhat.com>
Subject: Re: [tj-cgroup:for-next] BUILD REGRESSION
 e76d28bdf9ba5388b8c4835a5199dc427b603188
Message-ID: <ZVObbkEVn8-fnzZ3@slm.duckdns.org>
References: <202311131910.pxATTnsK-lkp@intel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202311131910.pxATTnsK-lkp@intel.com>

On Mon, Nov 13, 2023 at 07:12:12PM +0800, kernel test robot wrote:
> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
> branch HEAD: e76d28bdf9ba5388b8c4835a5199dc427b603188  cgroup/rstat: Reduce cpu_lock hold time in cgroup_rstat_flush_locked()
> 
> Error/Warning reports:
> 
> https://lore.kernel.org/oe-kbuild-all/202311130831.uh0AoCd1-lkp@intel.com
> 
> Error/Warning: (recently discovered and may have been fixed)
> 
> kernel/workqueue.c:5848:12: warning: 'workqueue_set_unbound_cpumask' defined but not used [-Wunused-function]
> 
> Error/Warning ids grouped by kconfigs:
> 
> gcc_recent_errors
> |-- i386-tinyconfig
> |   `-- kernel-workqueue.c:warning:workqueue_set_unbound_cpumask-defined-but-not-used

The function is going to be used by a follow-up patch that Waiman is
currently updating, so I'm going to leave it as-is for now. Looks like we'll
need CONFIG_SYSFS || CONFIG_CPUSETS guarding it no matter what tho. Waiman,
can you please add that to the rest of your series?

Thanks.

-- 
tejun

