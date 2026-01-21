Return-Path: <cgroups+bounces-13351-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MMk9MqEYcWmodQAAu9opvQ
	(envelope-from <cgroups+bounces-13351-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 21 Jan 2026 19:19:13 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE3E5B2CC
	for <lists+cgroups@lfdr.de>; Wed, 21 Jan 2026 19:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D3C68B0601A
	for <lists+cgroups@lfdr.de>; Wed, 21 Jan 2026 17:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D2835CBD6;
	Wed, 21 Jan 2026 17:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="sftzYOrw"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD57C2F5A10
	for <cgroups@vger.kernel.org>; Wed, 21 Jan 2026 17:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769014890; cv=none; b=HRxGis2JoWq9Rsz7n9vSa9s4fAhe1xfCfZYElke8EB2jS04mtrEsnCQFnsjAEoxkFcKXEhX0gjcjs94tcFAnto4Gr5ZXe2KszxgwoA+FIHRI6UqXTSSv7pA29D3jlZtf/QsGWMjJ9uwtdQKqQgQ/8musijzIAG9TuqZ5h+DVcDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769014890; c=relaxed/simple;
	bh=NS9g2AnxEzPHm6ksAl6Sb6ejmlCfx+QLJmDJAUrWVpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rCP83VfdxOri+AYUk7Awzc41UE2cGsYO2Tp9c+9t3glAGf42rWxHyv6TjVbVr4bomdNPNCV3/w1nJDu4t09RGCVhMIkGE8XE7cp+prVRaG90Y5CK7DMmAZ+w5iQZpCmINO/QeKf7t0Zz5+p96WgLPxMGXASqZRWsYGUIEhi7gQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=sftzYOrw; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-502a4e3e611so392021cf.0
        for <cgroups@vger.kernel.org>; Wed, 21 Jan 2026 09:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1769014887; x=1769619687; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K+uhcT8kuOkj3B6sfe7+hqE5T2/49CGXbVjQAIL7CP8=;
        b=sftzYOrw0uDJYWWIPrnzdwmd2sborS7TbSKGD9UwBBkrbf+tjK6WpBGWizad6oU9VI
         uiBtDtZK2lbYtuAabXo9dPK4M7NgRmmZIAbSKa4V8Z955r8D2WmJUcw6wjEvtXwnJil/
         l4A/IiGrgcnRGtEVHnVgYPFqOqI77qZuroaG52mEVcQcz2qCYqslGRhSMDK1k3+TjIfd
         N+N/rsKt/vQw9i57lSiqBFcx2/GKUnP9HCdS6MAwrKVlayTCsFnYy0IlLsFRqvBoTChE
         z6/ZQKwrVUZCI857y9E1oMFGRhR+3M2tj/VTAP4NUr68302xCnOorc6q9NbEaZT5/Ogz
         NfNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769014887; x=1769619687;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K+uhcT8kuOkj3B6sfe7+hqE5T2/49CGXbVjQAIL7CP8=;
        b=wLad9DpcV9ZqrldIacVq+9igp/HiVciB0fcB8R4WQWj8Mqx+tcktbCySInCJGHcxMx
         bEL+KYLHKkrG8dTSmfyQXq+VC5uLeiHu3AjJCQpHsRxODi38LpYdGqhCmkSVI77obOCZ
         5F16W99wz1E36PcIafNpgDHn1rY74e2mMCn+k+RYXXmVygg9yeTi6N3ZBIlBig5bGmiK
         NLgcFYAaauovK9xfIeS7Gnn8AD2OFoz7oIqosZxPzkcOmd47FECIO9Yy263qfuoVEJVR
         dqfs9nDwFZp1BgjsMuZCtATyGKiIGYksLLcnBCN0C6zOqPDduIJt08LHQqdrIaIN58um
         CdJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLXCHU0HjlQzfopLBfB0PIIz2uSERljXqOQrL9F11IeGpW/Ysdh2SRn0qtdtNJVhpdnVfb5++E@vger.kernel.org
X-Gm-Message-State: AOJu0YzdmoxiJdipKczxAxSqF/fExAZi91NHtxofbxbdXZ4wNR2WDnYr
	e5zWdi0txaBnblNsFHlai8DfAam3E/WMF8CPkBjXFm9spX5exT3TMq389jZ1/Ny5Rgg=
X-Gm-Gg: AZuq6aLZmNOKvX6hD7vxqRlqXlKrPzO+3mulLckhvqnTc7KgI4u1HUliixtQsRcYVvT
	iyWxoLnHFH7w6djVbbl/sqI2TGIAUIul9EKHRbjpBq3vZY9zdseJvQmkDbKFDwnEQG0RLWQjX0e
	rEfCKgaN0b+xmlIffIIoqoezks05oo0uJit5iigcwgUtVUuYFlREtq3ZTP/jGXlYndRk5Eh/21m
	6Zr0wa8Xg1j+x0JPyr8kdTaWBWBAXMWpDrhQ6kJ0gtnrKMq5L6pjM6MP/QM0icUoAP07qqg9Tqk
	XjriS7NG2RT5WKjh/tRfKC5h7RyBvr8S5Rrh0ilId/whoe7aJrfgUH//3S3Tw7WGd5VBxISGvkx
	XKn/MLbwz++5WAA2NFEkWHITGdKk664NDEHx09480ZNYL/IPAGkyKu5SjA0Cnsab1EyJusjxvea
	sdrhe9ipL6tV2Z4csmdCEZ
X-Received: by 2002:ac8:7d45:0:b0:4ed:a2dc:9e51 with SMTP id d75a77b69052e-502eb5bb64fmr1219411cf.21.1769014887073;
        Wed, 21 Jan 2026 09:01:27 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8946ecce11dsm23458376d6.31.2026.01.21.09.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 09:01:26 -0800 (PST)
Date: Wed, 21 Jan 2026 12:01:25 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot <syzbot+079a3b213add54dd18a7@syzkaller.appspotmail.com>,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, mhocko@kernel.org, roman.gushchin@linux.dev,
	shakeel.butt@linux.dev, syzkaller-bugs@googlegroups.com,
	Muchun Song <muchun.song@linux.dev>,
	Minchan Kim <minchan@kernel.org>, Kairui Song <ryncsn@gmail.com>
Subject: Re: [syzbot] [cgroups?] [mm?] WARNING in memcg1_swapout
Message-ID: <aXEGZUb4TkuIUsvT@cmpxchg.org>
References: <696b56b1.050a0220.3390f1.0007.GAE@google.com>
 <20260117165722.6dc25d72fd58254cb89e711b@linux-foundation.org>
 <CADhLXY6ACKeyLrjARTTdfWyrvUdLbtD-wXiQvsvhsbGjwmUqDA@mail.gmail.com>
 <CADhLXY7FJqRLjX7X2yJfa0=iDbUAMwhS35cOEExW+qBJWAnt+A@mail.gmail.com>
 <20260118125311.e1894f598e2a8ef626f47f25@linux-foundation.org>
 <aXDponX2AQoACOaI@cmpxchg.org>
 <20260121083526.81996ffd70ff4efc8484fd4d@linux-foundation.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121083526.81996ffd70ff4efc8484fd4d@linux-foundation.org>
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[cmpxchg.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,syzkaller.appspotmail.com,vger.kernel.org,kvack.org,kernel.org,linux.dev,googlegroups.com];
	DMARC_POLICY_ALLOW(0.00)[cmpxchg.org,none];
	TAGGED_FROM(0.00)[bounces-13351-lists,cgroups=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,cmpxchg.org:email,cmpxchg.org:dkim,cmpxchg.org:mid];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[cmpxchg.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FROM_NEQ_ENVFROM(0.00)[hannes@cmpxchg.org,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[cgroups,079a3b213add54dd18a7];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 5BE3E5B2CC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Jan 21, 2026 at 08:35:26AM -0800, Andrew Morton wrote:
> On Wed, 21 Jan 2026 09:58:42 -0500 Johannes Weiner <hannes@cmpxchg.org> wrote:
> 
> > > > I tested with the latest linux-next in sysbot. It is working fine
> > > 
> > > Great, thanks.  But we still don't have review for this one.
> > 
> > IOW, this is not necessary anymore. Kairui's (cc'd) fix which you
> > picked up fixed the syzbot reported problem.
> > 
> > > For some reason I don't have cc:stable on this - could people
> > > make a recommendation?
> > 
> > So this:
> > 
> > > From: Deepanshu Kartikey <kartikey406@gmail.com>
> > > Subject: mm/swap_cgroup: fix kernel BUG in swap_cgroup_record
> > 
> > can be dropped.
> > 
> 
> OK, thanks, I'll drop Deepanshu's "mm/swap_cgroup: fix kernel BUG in
> swap_cgroup_record".  I understand that Kairui's
> mm-swap-use-swap-cache-as-the-swap-in-synchronize-layer-fix
> (https://lkml.kernel.org/r/CAMgjq7CGUnzOVG7uSaYjzw9wD7w2dSKOHprJfaEp4CcGLgE3iw@mail.gmail.com)
> has addressed this mm-unstable issue.

Yes.

> However Deepanshu's "mm/swap_cgroup: fix kernel BUG in
> swap_cgroup_record" has
> 
> 	Fixes: 1a4e58cce84e ("mm: introduce MADV_PAGEOUT")
> 
> Which I assume was mistaken?

Yes, this appeared to be a misdiagnosis of the bug sequence.
MADV_PAGEOUT was in the stacktrace, but not the culprit.

