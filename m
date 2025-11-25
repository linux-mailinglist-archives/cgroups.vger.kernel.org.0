Return-Path: <cgroups+bounces-12192-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9478BC85080
	for <lists+cgroups@lfdr.de>; Tue, 25 Nov 2025 13:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8FF8A4E7D4D
	for <lists+cgroups@lfdr.de>; Tue, 25 Nov 2025 12:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85ED320CDF;
	Tue, 25 Nov 2025 12:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CxbVjZRH"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E7127467D
	for <cgroups@vger.kernel.org>; Tue, 25 Nov 2025 12:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764075330; cv=none; b=JrTQ3ggVwWteipWERrLc2NnQHPc+fxCj2wJD+6Ebe+gjXh5//D8GLlHSXkH4wLnpZVTOnGh3SQknhfrLP7FXF3CQyKyF1Ehl87LogxVcv1R99t//woCpJiggp2lRWN+DJNBkqKwrdUvGtoBpXG7/1Ll+oa07WMECSbfYjt6TyPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764075330; c=relaxed/simple;
	bh=TcIehyyg9NOgFB+aqxQUl1XQcbzEAynNMvyg8CX0Iz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dHfHUVbzj/3uB5PM+TsN0ns9PI5LlcTqlJ63tvEcpAAVjG5mHzxCO8pSXr4vSWTwHsF3bOMqcnQOKPVti/iYxyyNp5mGiLiYtQ36ENEWr0PbWiKew28CXwj53BhZxnjDjo/LmOhzd8WtGbk5vR721v1lbcc3A87PtnLsf+6UlRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CxbVjZRH; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4779adb38d3so39015435e9.2
        for <cgroups@vger.kernel.org>; Tue, 25 Nov 2025 04:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1764075327; x=1764680127; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=usCzcCtVI6XgCiCu4NS8NEIAX55CiKwZAm0iUXb+TsA=;
        b=CxbVjZRHmdeNmVkpr656+7d2ejK+CRH5xbGN7WoQ1OQ6RSHHh4OemSB+Ts4ZVLydJa
         i+P2cmzrjX+PHuVDpSmB/Rm9YpkTSjr/pqoFg8pmTCY/FU1MR7Fkzv6of1c8WVTwAWZC
         135wz6s+2WNVkWja+VN3+41e2gX8oILAA+CmXxTzb2eCA8TN6kSPJSsa/CAGpSao6x/E
         366acJ67JjjaSN/7Qo7z6pX4zvh4Blwk1y6BDbdG83jvOAAFht2r91fp8EcdeKpQGh6W
         B8EslKrt8PU6/IWPUadQR1+AT7OaBclYJMHoYdCaXlDof4m/Z7u+f4TwtlnX1jH6KJW5
         CXMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764075327; x=1764680127;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=usCzcCtVI6XgCiCu4NS8NEIAX55CiKwZAm0iUXb+TsA=;
        b=vtNjGs/oGLBTRtTTzEKzTDhqvHQMT21jj2VM6jl4mSJEFG9IzQaNrxz23xvAGhqyJJ
         KlS5eB53NchIa94tVHl43oRu7T68PtOqm/axP6l7o5lesOXsjbiM8PIpsm6gXpC+LBuq
         s4oqjYOWLo9atzTCerXTSB9CRUIGcFNq+eUsv2zrZMtfze4nUmDOoc5fa87WWdivccCm
         N1nAZ4B5hveGrr5ozhkwHIuRJ064wxzvY/HE6jBtMwaoHO9JBwuXrubZZ/gg9LgAm2Ae
         OdprUUxfsVMLX3GXyaMO7xh8MJT/UzzJ4BLfl44eOdLVu6JblJD8H3afRK5FdEsFdKVZ
         zAZA==
X-Forwarded-Encrypted: i=1; AJvYcCVV1Ujnsx3vfAbKFMM3rIHegr1unQ3Mepb2niqtzVr2eUzn7/Zl8XWSeOe7d0q3sR8ltapkfomM@vger.kernel.org
X-Gm-Message-State: AOJu0Ywsz3yVX0iyUqPDbRrvxDeLLal2vjMzQjdAjrJHwPKSfEmphavr
	280gjlcrNVh3dNs4nHgGzW4RLAvaf9KNG2VzUmpAedtaWlSYVVdRoGRrwsPc9hEOPKA=
X-Gm-Gg: ASbGnct0GF+//gVaYd3xY1phokGb4k76VIuivIdJ3SFqWkK6eCMylQbrTHi6vNk86+R
	P6THbz5BZc3DyCatTi0fhZitO8F2m8wcAE8AOhJYlZdTie0GzxLGu+H+YsbbWBOtV0eWFYpvzuc
	aagdcxXt0+eiOJw8FppQoFdgwXBf0fK0FIVSEBpAF+RbHNSiUn2kLJisHJ/M5pggsz9jjIlQVRK
	pbh1n4gDHJUDUOEjK1opMo94++OhbG5M8yfRT1LaEtdq/8Asqsthu02OYICu+OOSJuvtCSLaJ2n
	+hlOXB0ZWevNYGkCbXUSLdefXr2nVYRFWQR+4UN7IdOlnAZWcpJzOPFhAuioKtQ51EPH3Nqukru
	OTNXOdRB5SFZHB3wUSaRYhsbo45xhjHc7Jci9Xf4AAQjgOEIyrExNTPTO0kp9+QyCBaERGv3TMm
	/ipzcMhJPJK445jVaP5ZmxYpwM
X-Google-Smtp-Source: AGHT+IHeNFHz77PnS9U9y/LXSC6SdqMAwMHknNtAmvznPS8Yog8Q67/4L/1KHix1NRlDrhL8Rpv3qQ==
X-Received: by 2002:a05:600c:3112:b0:477:b48d:ba7a with SMTP id 5b1f17b1804b1-47904b2b2e0mr24822815e9.32.1764075327005;
        Tue, 25 Nov 2025 04:55:27 -0800 (PST)
Received: from localhost (109-81-29-251.rct.o2.cz. [109.81.29.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-479040bd209sm18794505e9.3.2025.11.25.04.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 04:55:26 -0800 (PST)
Date: Tue, 25 Nov 2025 13:55:25 +0100
From: Michal Hocko <mhocko@suse.com>
To: hui.zhu@linux.dev
Cc: Roman Gushchin <roman.gushchin@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>, Kees Cook <kees@kernel.org>,
	Tejun Heo <tj@kernel.org>, Jeff Xu <jeffxu@chromium.org>,
	mkoutny@suse.com, Jan Hendrik Farr <kernel@jfarr.cc>,
	Christian Brauner <brauner@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Brian Gerst <brgerst@gmail.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	cgroups@vger.kernel.org, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Hui Zhu <zhuhui@kylinos.cn>
Subject: Re: [RFC PATCH 0/3] Memory Controller eBPF support
Message-ID: <aSWnPfYXRYxCDXG3@tiehlicka>
References: <cover.1763457705.git.zhuhui@kylinos.cn>
 <87ldk1mmk3.fsf@linux.dev>
 <895f996653b3385e72763d5b35ccd993b07c6125@linux.dev>
 <aR9p8n3VzpNHdPFw@tiehlicka>
 <f5c4c443f8ba855d329a180a6816fc259eb8dfca@linux.dev>
 <aSWdSlhU3acQ9Rq1@tiehlicka>
 <6ff7dad904bcb27323ea21977e1160ebfa5e283d@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ff7dad904bcb27323ea21977e1160ebfa5e283d@linux.dev>

On Tue 25-11-25 12:39:11, hui.zhu@linux.dev wrote:
> My goal is implement dynamic memory reclamation for memcgs without limits,
> triggered by specific conditions.
> 
> For instance, with memcg A and memcg B both unlimited, when memcg A faces
> high PSI pressure, ebpf control memcg B do some memory reclaim work when
> it try charge.

Understood. Please also think whether this is already possible with
existing interfaces and if not what are roadblocks in that direction.

Thanks!
-- 
Michal Hocko
SUSE Labs

