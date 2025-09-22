Return-Path: <cgroups+bounces-10328-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9013CB8FC3C
	for <lists+cgroups@lfdr.de>; Mon, 22 Sep 2025 11:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 491C73B1354
	for <lists+cgroups@lfdr.de>; Mon, 22 Sep 2025 09:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC71287262;
	Mon, 22 Sep 2025 09:33:21 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C2F286889;
	Mon, 22 Sep 2025 09:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758533600; cv=none; b=BCviaMDOpB6y6EioE+oCiuYzJAfTVAKOHEBSrJx08jokd7MHin4E3vEc+HFdlSxhJ8Dng5SiDwWYPXdlV0TrtdAU27GP649WJNCL7xAmDggWem7JUC1R6tpAN1k1Gbld9AItRkBCUwLidiuVQnbBIoqFYV3rcFeuGwGVGL4WCU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758533600; c=relaxed/simple;
	bh=8NgYybOv9WNWz4bn+lQs2bqTHjIC8EFd9xRM5WE1Adg=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=m6gxVdn4gN/B67lJVC8Ai59k45QMxwZe1Xzh6pn22zx2mmYyhUfT5H7pAWfydo5UOgkM1gDKMMaXjhfWrU67gSqGxn/NMWVCEDkso3wq6iD04vTuI+/03EaVlKvfl4MoZYwI87tnv0DmJt83BxYU+tO2L/oSZ7fnS2GvvAT0+Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4cVdFf3Vtkz501bS;
	Mon, 22 Sep 2025 17:33:10 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl1.zte.com.cn with SMTP id 58M9Vu75080767;
	Mon, 22 Sep 2025 17:31:56 +0800 (+08)
	(envelope-from xu.xin16@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Mon, 22 Sep 2025 17:31:58 +0800 (CST)
Date: Mon, 22 Sep 2025 17:31:58 +0800 (CST)
X-Zmail-TransId: 2af968d1178e17d-217fb
X-Mailer: Zmail v1.0
Message-ID: <20250922173158997VPIUgFcs8UoazWb_JQIc9@zte.com.cn>
In-Reply-To: <aNEG5W0qLPKKflQA@tiehlicka>
References: 20250921230726978agBBWNsPLi2hCp9Sxed1Y@zte.com.cn,aNEG5W0qLPKKflQA@tiehlicka
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <xu.xin16@zte.com.cn>
To: <mhocko@suse.com>
Cc: <akpm@linux-foundation.org>, <shakeel.butt@linux.dev>,
        <hannes@cmpxchg.org>, <roman.gushchin@linux.dev>, <david@redhat.com>,
        <chengming.zhou@linux.dev>, <muchun.song@linux.dev>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <cgroups@vger.kernel.org>
Subject: =?UTF-8?B?562U5aSNOiBbUEFUQ0ggbGludXgtbmV4dCB2MyAwLzZdIG1lbWNnOiBTdXBwb3J0IHBlci1tZW1jZyBLU00gbWV0cmljcw==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 58M9Vu75080767
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: xu.xin16@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Mon, 22 Sep 2025 17:33:10 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68D117D6.003/4cVdFf3Vtkz501bS

> > From: xu xin <xu.xin16@zte.com.cn>
> > 
> > v2->v3:
> > ------
> > Some fixes of compilation error due to missed inclusion of header or missed
> > function definition on some kernel config.
> > https://lore.kernel.org/all/202509142147.WQI0impC-lkp@intel.com/
> > https://lore.kernel.org/all/202509142046.QatEaTQV-lkp@intel.com/
> > 
> > v1->v2:
> > ------
> > According to Shakeel's suggestion, expose these metric item into memory.stat
> > instead of a new interface.
> > https://lore.kernel.org/all/ir2s6sqi6hrbz7ghmfngbif6fbgmswhqdljlntesurfl2xvmmv@yp3w2lqyipb5/
> > 
> > Background
> > ==========
> > 
> > With the enablement of container-level KSM (e.g., via prctl [1]), there is
> > a growing demand for container-level observability of KSM behavior. However,
> > current cgroup implementations lack support for exposing KSM-related metrics.
> 
> Could you be more specific why this is needed and what it will be used
> for?

Yes. Some Linux application developers or vendors are eager to deploy container-level
KSM feature in containers (docker, containerd or runc and so on). They have found
significant memory savings without needing to modify application source code as
before—for example, by adding prctl to enable KSM in the container’s startup
program. Processes within the container can inherit KSM attributes via fork,
allowing the entire container to have KSM enabled.  

However, in practice, not all containers benefit from KSM’s memory savings. Some
containers may have few identical pages but incur additional memory overhead due
to excessive ksm_rmap_items generation from KSM scanning. Therefore, we need to
provide a container-level KSM monitoring method, enabling users to adjust their
strategies based on actual KSM merging performance.

> -- 
> Michal Hocko
> SUSE Labs

