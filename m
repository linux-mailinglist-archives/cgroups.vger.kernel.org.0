Return-Path: <cgroups+bounces-6609-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2861CA3BFD8
	for <lists+cgroups@lfdr.de>; Wed, 19 Feb 2025 14:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38B511885172
	for <lists+cgroups@lfdr.de>; Wed, 19 Feb 2025 13:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0401E2853;
	Wed, 19 Feb 2025 13:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="BTOiuFO1"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAC51DEFE1
	for <cgroups@vger.kernel.org>; Wed, 19 Feb 2025 13:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739971630; cv=none; b=aLHmaPkRfsjde7GheCpHyeENP0rwKdlthgsf+TdtcV+0D1+2q/vsNpE+Src0X+68VypjFhbbSowxITkkhaYcwDlAhLAwnF2k025nW1d3ITq/FvMTeEVOj7a3Y5FkVmX/Sl7iFU3gVUzja/hcOZE3QE8lUmHt6sKN0KnEquzLGho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739971630; c=relaxed/simple;
	bh=Q3FQtZmUaIiR7VL6lpXl11JaqfwOrpF7BhaMsoV9jqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i4AHBZcIOiJ0yXLXe1pdw3lTptXPMRhPOUXEI0o3emUDQCTwnMRCnGrgQP/WMRDL6tfe1oXOD2mGyHczt8wjxY3qWgvcroQOxr1VXEjQFRGQp/Q3vMuTtiQ/P5MdoQF11p2Rku4XByENOX0SAvmZ4yq1HhcjKUEaEO5yestxrd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=BTOiuFO1; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4398e839cd4so5225335e9.0
        for <cgroups@vger.kernel.org>; Wed, 19 Feb 2025 05:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1739971622; x=1740576422; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P97+9Izdp48aMPe+x/Vt4fyC+VGy5GXgsbg5en6vb3I=;
        b=BTOiuFO12YTJ9Hi4cXy2+dWnMxRv4FQ5oOLjIaMVPtIUS8Ftfip8M6JbXxystHaq4Z
         9iw/FiInQX3tjnJaYW89XShvN3/DLWbxuRpgIPKcteJyY0ury1aYgDTI15GOThn2/EAq
         suFG0KBtEhWlGh3sI7ELPqK75j1dDmqB241RU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739971622; x=1740576422;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P97+9Izdp48aMPe+x/Vt4fyC+VGy5GXgsbg5en6vb3I=;
        b=CiNtF+f1kA9l1F8wGIj3RXQhEMRWyYw4+lPop4/r66Xvj+if6leg7ZSeGHu4uu0I1i
         0qIfVsEBjKbNT4ThHzLuX6KFoWhIF7VojlCZs6An+6m09+4e/yXHYnHCnrLScpwPws/I
         BC3pUGKYLIqhc6tfXTmuXaJjo5IXX7kCyPTSYPCr7FcwIzfj49XVM1kMx6tQ8QyjTANA
         w1w6nO+V8WWNu21zLmPbbcsHYw9AEdQQErCzKgpsOSriqr4puaQTDLHTiHaoPsfCxU+S
         NV1VtnFPkY5fhi3B8f/tbASQh37jer4EtBaKS2x9dMDzfr6JSzUAk9pQGCiuumnwjRdc
         UHUw==
X-Forwarded-Encrypted: i=1; AJvYcCU1eVFMMBvBDePC+VH1YJOh5fo/ERJlMGzIn891nLJExqu9MLg7npzfNgiD5WURuiaRdfuxgybE@vger.kernel.org
X-Gm-Message-State: AOJu0YxVSh0q45jtNGg+PvZ67Q56FM4zUQ0W/k+0QoEbxiCcBA7z29t9
	w2NZaYXphr6XJmWsvHY1+Wi8LTmHhTrBpApvPyDhAGDS5yymLbzq9ue1We+Z9c0=
X-Gm-Gg: ASbGncvkp5u94vZgUSPhVnZB120XqbTOaleylg8AQSmNFY8sjvYTHWm0sTa9jtD4vjB
	+c7wkGJheQd0BPsSSWVnNM2fgxI4qelDNez+UbNMVj6qll9hUMAnOApRbDC1c3W098Gj6oAEwXA
	vKbaIX79dCF4/azGSqnDCKGOBuoOtyL3O3pRG3MTRltU7ihvdFuJr5KHcCOyGLFPG1RkhjKaVem
	/C/5+bp28xjMi97Bcn8hVFwZ1sBONDlar6WxSBV6GssjJvkbyMM4bQ1/6ijTRHm2fDQPFHERGiZ
	z4K8Dfew9xabcgLtj82xQULsI+Q=
X-Google-Smtp-Source: AGHT+IEwj9Cg3rz3rMnKfCwVitwHErBe+cWUY6n5CQbHW1Ovl4AwLj/OmgmR9qK49M7TGJhzhA/ZmA==
X-Received: by 2002:a05:600c:4586:b0:439:8634:9909 with SMTP id 5b1f17b1804b1-43999b70cbbmr33220245e9.14.1739971622313;
        Wed, 19 Feb 2025 05:27:02 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4398242f2c2sm94444545e9.20.2025.02.19.05.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 05:27:01 -0800 (PST)
Date: Wed, 19 Feb 2025 14:26:59 +0100
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Maxime Ripard <mripard@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, Maarten Lankhorst <dev@lankhorst.se>,
	Friedrich Vock <friedrich.vock@gmx.de>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	David Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org,
	cgroups@vger.kernel.org
Subject: Re: [PATCH v2] cgroup/dmem: Don't open-code
 css_for_each_descendant_pre
Message-ID: <Z7XcIxX_LDxODXZ9@phenom.ffwll.local>
References: <20250114153912.278909-1-friedrich.vock@gmx.de>
 <20250127152754.21325-1-friedrich.vock@gmx.de>
 <7f799ba1-3776-49bd-8a53-dc409ef2afe3@lankhorst.se>
 <Z7TT_lFL6hu__NP-@slm.duckdns.org>
 <20250219-tactful-attractive-goldfish-51f8fc@houat>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219-tactful-attractive-goldfish-51f8fc@houat>
X-Operating-System: Linux phenom 6.12.11-amd64 

On Wed, Feb 19, 2025 at 10:08:57AM +0100, Maxime Ripard wrote:
> On Tue, Feb 18, 2025 at 08:39:58AM -1000, Tejun Heo wrote:
> > Hello,
> > 
> > On Tue, Feb 18, 2025 at 03:55:43PM +0100, Maarten Lankhorst wrote:
> > > Should this fix go through the cgroup tree?
> > 
> > I haven't been routing any dmem patches. Might as well stick to drm tree?
> 
> We merged the dmem cgroup through drm because we also had driver
> changes, but going forward, as far as I'm concerned, it's "your" thing,
> and it really shouldn't go through drm

I guess we could also route it through drm-misc. Either way I think we
need a MAINTAINERS entry for dmem so that dri-devel gets cc'ed. And then
make a decision on which git repo should be the standard path. I think
either is fine, but at least for now it looks like most interactions are
between dmem and drm, and not between dmem and cgroups at large. And in
any case we can just ack patches for going the other path on a
case-by-case basis.

Cheers, Sima
-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

