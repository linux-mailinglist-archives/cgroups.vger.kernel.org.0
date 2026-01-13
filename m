Return-Path: <cgroups+bounces-13142-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 832C7D188D3
	for <lists+cgroups@lfdr.de>; Tue, 13 Jan 2026 12:46:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DB81E300A3F3
	for <lists+cgroups@lfdr.de>; Tue, 13 Jan 2026 11:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D856E38BF6A;
	Tue, 13 Jan 2026 11:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b="wS6urJiK"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AD52BEC3A
	for <cgroups@vger.kernel.org>; Tue, 13 Jan 2026 11:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768304800; cv=none; b=Hssvo9fK/6LJpDjO66zjWC+U0EBmXwzken2Y1+v3O10ALoUxdNTQYQ29yKfEXEILi0uhS5EEtV68fbxLt3E37+NjdBohuLIisxu6uJMPctNe9qFW3cPmXH2PPfZEx2dibC4PMAWNcWkCocJ4UONDbzw5ewVXqH+P4j5K3HJ+tQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768304800; c=relaxed/simple;
	bh=bRkLhq27YZPIJW+0SnrDhxpKsQQkrQuDVtylqivBmoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kSQ5jCOggoOcPoQniKqNPLDgAJDbA8xME1a4hYzBVWl762wL9mI77wfMPETzbnyB89rv/5MsF49whGgDgFVC/NyaBbgHBayGdOQfWD5Expw5iy2LrtsdBPpfWkw+oC1W3UrJXBMEAxkTxxA2rdAX4AJ7N+tmYRk0sedC8vXBiJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b=wS6urJiK; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-4327555464cso4470263f8f.1
        for <cgroups@vger.kernel.org>; Tue, 13 Jan 2026 03:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20230601.gappssmtp.com; s=20230601; t=1768304797; x=1768909597; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zpwTG2Sf7DbbfCImgCuG0RDxi2dp7JwGDXJ+APqy7LQ=;
        b=wS6urJiKrhklv/LAFUwhxiU/3/GJzv2RZ9qSVcwYtqthBiCYnBciCDvinT6RKWdo9G
         KdpRo5OD702z0aiTKwExJaWLp6+YLg7VAkDBsYV2UsDNBDZ/iWv+8+hsMldd+b+ctnW3
         HCogkWtsMrIJxac0ChrQe+zrTb4Imo5ZmUaLp/iFLAFb+Ng4MZkSB3vLew7iYsD50MMo
         SIQRcqrLCbU1LBHgsRD9wnjRCfCPYErgME+9AajhsDSLDeTW7Tdth3/0cUHFabLda+s4
         yFXU438AgdnBRBLRK6hm2zhpGYl/iFvRBn3Yb1rRGF9ejJle5NLk53Rt06s2bx4guCG7
         5inw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768304797; x=1768909597;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zpwTG2Sf7DbbfCImgCuG0RDxi2dp7JwGDXJ+APqy7LQ=;
        b=MX5UvfRmZGS40qNU3a333yz0N0kjIFTBT7oiMViOIYcCLgLx6CWsrO54+4ph8arD6m
         gUfdqF89ho22AW8lZHMSSHGeFQXIRh9Cb35g1tb+zYBARPLJGf/zUSLR2Zt4mkfPJmir
         DmHHeGsYga0O+oXxGfI3KMRn9wp+OxItCghYMgwU+WSPHhbABtBrBE4ZBrjGzpXGMMUz
         UFYK10InszMedXRrV4+PZRwgc7hpJT8Rh6vNDKlAPSbRVUGB1L5ykZxVKm+6TfmBSfAg
         zEOyElTAccDPG7qCQaHkl4x8rwGeOw4ErHGy6NgcvmDVppdEssWrOWlviozQkJIa5IlY
         Nz6A==
X-Gm-Message-State: AOJu0YwpaIr9pkvBTQ7kZWULHVgDAG/tK73azu+UUGh17fvQBsZR+rhK
	SGD1IKiFK1d6Wv6qPKnzdPJak9quHiXuaOSZ95sc+g0PoJ8+CDZS6Yt0df0R4O/Xs28=
X-Gm-Gg: AY/fxX6bq/KDCRT4NLib6WTkd1PPL2ZDlc2wWsBxORzYnGfNo5YqN2bag0+HxvEUCHa
	Bl7TpfkzdZ4odBPzqEeqhpsClm8EvG3L+Hvb4KVn0oErg7MOlPTpSKeSouHAfn0luH034eTTUko
	ew9gnWmCXdg+R8+4nMxT46pD/9lEv0NlaDNszV5qAF3NrNJ889wRFKPzkUwKS5voN+x9HIuGOYK
	g12/q/fHY9XQ9vmlVkLZu67wt9xSCfMiknTuzzS0LIdFXfHQXqaITyIWF0qyiMWsFPWQ7Y2Rv2n
	WIrDTF9Hu7L914yuCGrv/iZsLu51r3HlMv4s/QbrDomqrLMR7pYLcKRyPVpjcll59r1qzEuwhfL
	G9tiQ17IAQOsaS4fhL72pdjeP+dvKXZz98V/ACOAMab01uoI4MHOAxfmsmMr9gGIq1BWk/kfzK6
	Tf1CFC+PKs
X-Google-Smtp-Source: AGHT+IGSGoImNRjJ/zxKTUYvkNxY2uhaSQaZSLB1xOPX0YvkH0lolS5XgtGOmxnWqgm3xBk7BQRRiA==
X-Received: by 2002:a5d:5d13:0:b0:431:9f1:e4c8 with SMTP id ffacd0b85a97d-432c377c652mr26769008f8f.17.1768304797273;
        Tue, 13 Jan 2026 03:46:37 -0800 (PST)
Received: from localhost ([104.28.192.60])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5df9c5sm44905344f8f.22.2026.01.13.03.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 03:46:36 -0800 (PST)
Date: Tue, 13 Jan 2026 11:46:35 +0000
From: Matt Fleming <matt@readmodwrite.com>
To: Jan Kara <jack@suse.cz>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org, kernel-team@cloudflare.com
Subject: Re: [REGRESSION] 6.12: Workqueue lockups in inode_switch_wbs_work_fn
 (suspect commit 66c14dccd810)
Message-ID: <eiilrap7jcpk7bneqvovbrqu6hdtzo2xra5tgqbg3wje2emzha@q3may6rqs5zl>
References: <20260112111804.3773280-1-matt@readmodwrite.com>
 <isa6ohzad6b6l55kbdqa35r5fsp4wnifpncx3kit6m35266d7z@463ckwplt5w3>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <isa6ohzad6b6l55kbdqa35r5fsp4wnifpncx3kit6m35266d7z@463ckwplt5w3>

On Mon, Jan 12, 2026 at 06:04:50PM +0100, Jan Kara wrote:
> 
> I agree we are CPU bound in inode_switch_wbs_work_fn() but I don't think we
> are really hogging the CPU. The backtrace below indicates the worker just
> got rescheduled in cond_resched() to give other tasks a chance to run. Is
> the machine dying completely or does it eventually finish the cgroup
> teardown?
 
Yeah you're right, the CPU isn't hogged but the interaction with the
workqueue subsystem leads to the machine choking. I've seen 150+
instances of inode_switch_wbs_work_fn() queued up in the workqueue
subsystem:

  [1437017.446174][    C0]     in-flight: 3139338:inode_switch_wbs_work_fn ,2420392:inode_switch_wbs_work_fn ,2914179:inode_switch_wbs_work_fn
  [1437017.446181][    C0]     pending: 11*inode_switch_wbs_work_fn
  [1437017.446185][    C0]   pwq 6: cpus=1 node=0 flags=0x2 nice=0 active=23 refcnt=24
  [1437017.446186][    C0]     in-flight: 2723771:inode_switch_wbs_work_fn ,1710617:inode_switch_wbs_work_fn ,3228683:inode_switch_wbs_work_fn ,3149692:inode_switch_wbs_work_fn ,3224195:inode_switch_wbs_work_fn
  [1437017.446193][    C0]     pending: 18*inode_switch_wbs_work_fn
  [1437017.446195][    C0]   pwq 10: cpus=2 node=0 flags=0x2 nice=0 active=17 refcnt=18
  [1437017.446196][    C0]     in-flight: 3224135:inode_switch_wbs_work_fn ,3193118:inode_switch_wbs_work_fn ,3224106:inode_switch_wbs_work_fn ,3228725:inode_switch_wbs_work_fn ,3087195:inode_switch_wbs_work_fn ,1853835:inode_switch_wbs_work_fn
  [1437017.446204][    C0]     pending: 11*inode_switch_wbs_work_fn

It sometimes finishes the cgroup teardown and sometimes hard locks up.
When workqueue items aren't completing things get really bad :) 

> Well, these changes were introduced because some services are switching
> over 1m inodes on their exit and they were softlocking up the machine :).
> So there's some commonality, just something in that setup behaves
> differently from your setup. Are the inodes clean, dirty, or only with
> dirty timestamps?

Good question. I don't know but I'll get back to you.

> Also since you mention 6.12 kernel but this series was
> only merged in 6.18, do you carry full series ending with merge commit
> 9426414f0d42f?
 
We always run the latest 6.12 LTS release and it looks like only these
two commits got backported:

  9a6ebbdbd412 ("writeback: Avoid excessively long inode switching times")
  66c14dccd810 ("writeback: Avoid softlockup when switching many inodes")

