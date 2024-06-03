Return-Path: <cgroups+bounces-3069-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D35D8D8A72
	for <lists+cgroups@lfdr.de>; Mon,  3 Jun 2024 21:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E0D41C21FB4
	for <lists+cgroups@lfdr.de>; Mon,  3 Jun 2024 19:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC89713B586;
	Mon,  3 Jun 2024 19:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y0zgcopp"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3627120ED;
	Mon,  3 Jun 2024 19:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717444085; cv=none; b=nTGFIMcqeBHzFVJ/CwlbH5EBETAnL3D6b4KVXR3py7/cHtPV1VsWo8LR2T7WDKBZ87Ci3g0Nqg20V5OLJEIFXv97RxyEVnVYqCrCPEtB/BfemCP3fkQnKzvXZGVEcWPHWD+DYLMJEuQEVQhOAArCltbcZ3Vq5SuoJtZO9GvaG0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717444085; c=relaxed/simple;
	bh=TjefhdPRAzXqj17OvT/X7NOgycIndaeg1sEXUfVpxIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vGAKro3ybLDR2T4Skl6Y+4ucfGoEXqioFXa3oHq8LjOkQoXuRfOcUQNLNz3KwU22EKS7Gz6/0V+Aa8M0IeDiiVWv2dr/YoB7WLVSMzEeKtPm2pz8kzy8Zpys78s/kHCFjC+gK8Efs2IXcUXxm21WQDAYOihUa7YE9rIsHWTASj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y0zgcopp; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-652fd0bb5e6so3830449a12.0;
        Mon, 03 Jun 2024 12:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717444083; x=1718048883; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PhCEH+hBS2EbWbRsasg0/V0BTvrNPYqT4/1Nc1PfZqk=;
        b=Y0zgcopprhEagX9H7gVulkIqd4Pmd/3TEiMCFWpWjK4T016sLC97YKU5g/EvBmCtcP
         lNptmcUpJyRDa/MVffxPqGa1z/nA2dZzxNVZ1YNC2pWJoKiEcfOQeu6KnrNKJ+nby0Fy
         MJe9y7Deq193PjtW1U1HUTBgYuQksG9yqVKoyf5B26G7RNCnrPuq8JnoIbqTMSNlJzOp
         yIV18JMGW6LQUNChqfTf2afX3lixBbk9u33zyrzpeCaNctfhzW1fVvlsXjtfOPHnOL1G
         IeoDRBIOUVryPlbrqaPUa+HeazMve8F+sgqI06n/4dviLmBI882CL0IrWBYS4mb6uyCf
         c8MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717444083; x=1718048883;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PhCEH+hBS2EbWbRsasg0/V0BTvrNPYqT4/1Nc1PfZqk=;
        b=pIOJlbEgQXDKjPGjpQDNDF9Z7dJZ0lsFG4Oea1o999Cjd4v44gPaA0a1uJKT87qveB
         pQ04Cm495M2uOXCdcSL6Ayq8E05sQHRB8TDfeDHpIFG9/nGJJzJuKNJeLv7zoO/ah9Gb
         VYVVTyUbJ74kIAo3UbHbbP9pVbTBVN4Cx+GAnvYEiLJOWROr5vMLUQ9Z8TNTASgvak2c
         aN6nq6xqJCP/oBkDq16tbA8jTYJ4uvVYvuKnnK4YPQkI75br61JrQMtN2iCzO/0wks9Z
         maW1d+S4o+CbJey+1mFj+w5E9EIqQqUEwlawGvord5dc7EecCFJnEJvh7lFTfACWhlRd
         QS5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWsb9j1JfZGeF0Sw2c1Cb9rVh5RrqLjsG3oi2Hm/EVGHc+k1dXJ8kEAeuVqTJLuQjmO/b/QHGmtiZGe0juekDL9DHq48sMKC7jPhK+ynJVQd/+FuhrM4I1prrqnN94O/FJ7jR9WcQ==
X-Gm-Message-State: AOJu0YxObU7E6d4lKEv3pV9Ce94ClvbSWuLQudasmyTflURAFNJWj8sv
	GUaCKBuljTaR+xl6HuzvvrA2pzZAPCfDT2S9m2onGm3AB78PEw0v
X-Google-Smtp-Source: AGHT+IEfqySC0xccz4s2MeJX/QR09dCSuq8yIiL3aIG9pyu7DFm0/4/OrXL/Bjfr+rsieLU4aRcWdA==
X-Received: by 2002:a17:90b:118f:b0:2b6:c650:fb54 with SMTP id 98e67ed59e1d1-2c1dc5df200mr7941276a91.49.1717444083401;
        Mon, 03 Jun 2024 12:48:03 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c1a77af9b0sm8908912a91.45.2024.06.03.12.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 12:48:03 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 3 Jun 2024 09:48:01 -1000
From: Tejun Heo <tj@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, Xavier <ghostxavier@sina.com>
Subject: Re: [PATCH-cgroup] cgroup/cpuset: Optimize isolated partition only
 generate_sched_domains() calls
Message-ID: <Zl4d8Yz-rlc0FUWq@slm.duckdns.org>
References: <20240603193822.1209999-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603193822.1209999-1-longman@redhat.com>

On Mon, Jun 03, 2024 at 03:38:22PM -0400, Waiman Long wrote:
> If only isolated partitions are being created underneath the cgroup root,
> there will only be one sched domain with top_cpuset.effective_cpus. We can
> skip the unnecessary sched domains scanning code and save some cycles.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>

Applied to cgroup/for-6.11.

Thanks.

-- 
tejun

