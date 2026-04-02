Return-Path: <cgroups+bounces-15166-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eEfEA0lgzmnvnAYAu9opvQ
	(envelope-from <cgroups+bounces-15166-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 02 Apr 2026 14:25:45 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09845389046
	for <lists+cgroups@lfdr.de>; Thu, 02 Apr 2026 14:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DE56330091ED
	for <lists+cgroups@lfdr.de>; Thu,  2 Apr 2026 12:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956423E121E;
	Thu,  2 Apr 2026 12:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eBPMscet"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38B23D3CEA
	for <cgroups@vger.kernel.org>; Thu,  2 Apr 2026 12:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775132701; cv=none; b=IIIWb35we3+boYM6I1YhBXOQpjzhvg8kqQVA8U7YtU3+MhFokG4WVEKfc9RdKQiD4INteMp0PCLAg/2wYTWBNqK3qzE20epgDZO7rXZotYTu4/5wvJIjRJXfU5r+jo90wF62FjIf1px7qZ0wZb+IZqCwE2dTPlagBCxBik10op0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775132701; c=relaxed/simple;
	bh=oRZ8kRRX4pkXj9dqw4wCdgK8U3A54Kgkv1lh5JPHNI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IlAlcVa3J8zRHkr9zwohS4UkHrojN0x5RN98CQqv87y165B1dS2IPHw5KsRszN4K8r7pU1mhES9+NHXGoIU8CUDJPoExPqo2hdDpKRPqIajAnllrJ+9gHMPXrOvx8YHG9OXHf2sgcoWGeDJlK0jmbR98O6+dp7A0Hb0WXErVCSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eBPMscet; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48702d51cd0so10213715e9.2
        for <cgroups@vger.kernel.org>; Thu, 02 Apr 2026 05:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775132698; x=1775737498; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pWNBOu549I6UawEB8azvVtlnMXVCESZYifMy8KsFwjs=;
        b=eBPMscetbR7R04+4uSqtBErAGQs8bzLdJFvXpEUyo9Bemb5JibzH6XF/ERZ4b06a//
         lfFjmBK2/G5SDghO/7ftBmf6x8z6bWM7F97e+KeNYwCYKs0Ka6yHnsWncbqfANjF5nT/
         +JrxB74SOY7rRdzAWzJdlFGrjbfgCdJe68cAZSEIFOu5FsayKXg2t1p5rtdBDEYlwtP5
         rzmpmgmuwGNPdvEWg6LworcoVBRcjzwWhA6EmO+XYl/CH+mAgKZD3qPWjUZRC04Q8FCI
         Ye043o7MMFVVovJgRrXRgaEfpItQztwfMe0wsf3D3FIbTgKFl6m5fBvI1RnkWhXOJv18
         NnuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775132698; x=1775737498;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pWNBOu549I6UawEB8azvVtlnMXVCESZYifMy8KsFwjs=;
        b=ckCzX3CNtD1VwmodvdAHBXGg9jrb/Fi30820xcCe+m5aVtZuj0rvSAamq4l0hVHNnZ
         Z2jdYRQ/hXcm+CIMutYyEe+Csp0f5/elkkxQspo+kW3WRXgIwcH4L9hnUpI/eHKK6Zuh
         OTEs7n+5lKWMMP+8yynghnZDlsUdxFfyBoL3rjyjsKd2UIj85v8g3mCXIDNmuLDzQ8DS
         UCHqKkREhts6h18c1v9o+c/V0iLJRh2hJr0nGvt7xP1+qDJ3r7uKMQthcM73SgUBdbgs
         AAQCDJmB15vlxgPd1B/3ZBHPlzbHDuxHMnWbFG6JsGYHpbTMf2Fk17bPejfsFNxCRWVM
         rtrg==
X-Forwarded-Encrypted: i=1; AJvYcCXGmIKz/ln6KQsTz1itma2ohWkn664nK0Mg4T62aBRoa6IATLZR4AXvL53l4HysVAJoBi/y6AJH@vger.kernel.org
X-Gm-Message-State: AOJu0YxWHDJRCDpnNGCNfM08PifT93CGgmnrVj6eJVa8P4Rt372x0ZC/
	UPadXZkzRyRepR/9XhkVelsyhPNk4TH89J9HootLT+BaIvMenGSeXobPbaq8e10lC7E=
X-Gm-Gg: ATEYQzxUutZS20doLDbL5+WkT8CliK8PbrmwqbpaYscrC1eyAuevWlvjc9cGrOFumIr
	bYWynn/JUX8co8idgTjotFIPNOjDRM/M+feuCYGQEGN8KmdlsjKhXTK2cE4cEF8EMigIAph5mYv
	ovcDkXMZogaMz33Rb8d/qvtci1a+N8hSaAi2PLYd4kxv8DFCd9MuK2Dge2PMGq/tQvhDLg+aUAG
	QvUtUUJ+H2qphSmVnzRowdrd6wOv9m7mq8PfPgmuGCAkmwK0duSwSq6gugJhe8H1+UtkBhWu59O
	nm27IDUPdBuMk9T6yA9BSMeaU+5WA+J1ufN/JjGPNL4JG1eCbAATta/TY4Y4m0ZhyhanQlz72EV
	XVzdRv1aEqJIuwb4MQc/BgJ6a+AHfcQQgsCImpzzsPwH1loYV0fV3i5vXbH6TI23GVh98R+cObu
	CFcXq0YO587JS5uhcgK6ApA6juytr+iHM=
X-Received: by 2002:a05:600c:821a:b0:486:fdba:f5db with SMTP id 5b1f17b1804b1-48883307a37mr124889995e9.0.1775132698332;
        Thu, 02 Apr 2026 05:24:58 -0700 (PDT)
Received: from localhost (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4d282esm7670221f8f.18.2026.04.02.05.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 05:24:57 -0700 (PDT)
Date: Thu, 2 Apr 2026 14:24:57 +0200
From: Michal Hocko <mhocko@suse.com>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@gentwo.org>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH] mm/percpu, memcontrol: Per-memcg-lruvec percpu accounting
Message-ID: <ac5gGS5eMFFCNaqH@tiehlicka>
References: <acqG2Mr5ekCn2HD0@tiehlicka>
 <20260330145608.3574897-1-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330145608.3574897-1-joshua.hahnjy@gmail.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15166-lists,cgroups=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhocko@suse.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 09845389046
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Sorry, I got side tracked and didn't get to your follow up yet. I will
try sometimes next week. Please poke if I do not respond.

-- 
Michal Hocko
SUSE Labs

