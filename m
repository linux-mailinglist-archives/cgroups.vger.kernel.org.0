Return-Path: <cgroups+bounces-10398-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5360EB962CE
	for <lists+cgroups@lfdr.de>; Tue, 23 Sep 2025 16:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0826217295D
	for <lists+cgroups@lfdr.de>; Tue, 23 Sep 2025 14:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B5F221269;
	Tue, 23 Sep 2025 14:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HPoluiIV"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1E51FDE01
	for <cgroups@vger.kernel.org>; Tue, 23 Sep 2025 14:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758637071; cv=none; b=C87a1R+zNZcL+kadikzebbgtaCBk5cnWV2dmlYgNIslgsxoymxTuYww/6860/Gj+FJ9FzwOYEvlrw3oA/dFGih5ZYwlcqtwTGeAQa9s2YnvYDBD5z6aqwFIGFGeWeHjzFF+musQ0ODVqNNqsX/EuUxAXOHcj7YEOJntPB8ehQtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758637071; c=relaxed/simple;
	bh=wSMFoqjyLN8Wd3bU4GJnrof3Pb9x9wfb4LqShQL8DPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f+J23ZdcwwN1z+bI8ELVs57qTL4EuF3AtcVi+B/ubc4L6Cyq51l4MZLI8wnlLsTmsBUSPAMfCy8MEOqWFtfzPOAw6GBoUsF9E+2TolSAazvILDGrCyEIxUnhxP+OWI95Nxp7IIbzPLkiyMqt6u5SdhdOLjN7wi5UIQA05kUK+Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HPoluiIV; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-afcb7322da8so1029951766b.0
        for <cgroups@vger.kernel.org>; Tue, 23 Sep 2025 07:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758637068; x=1759241868; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=A5q5N3nLYy9yP+B4kwAaZrbrxG23b0NBI/IKB6m71lg=;
        b=HPoluiIVEI38W28nZs0I9bpmzLGWwnUgG0QeoTFSqWFYAquFFnKABFmz2lJgoQXQPt
         1SHB/luv8gnHY2J0+PfDl23RrHUOcaBhhV5RwhhJleefcdPfCRoMDOuicLNen2dztL5k
         HkPJhtDwZ/oZnuyxz+vF2ttaMcrgVBcLtNti4JfRQ6n/pmEBWrE8sRjINKUElvzBUFvu
         UO35SYugkY6eWBI0uB/APD9V1HxP+WP+kmcrk3/yeM0/pgXdF+xdg4HTeDdBkQFspaoJ
         Zp3VOGMqXjL/Bai+BohEn5qm78FmwWCRZOcpKXhJ6WUT36eiDUhLyDFjI0DO66FCS7xF
         /JFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758637068; x=1759241868;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A5q5N3nLYy9yP+B4kwAaZrbrxG23b0NBI/IKB6m71lg=;
        b=Xonih3ODkj9RwKUVtA3fC5WK0O7agqXV2UpuwKkF7+QZdx+EeBUA2z5gkklbXzODDg
         bBkSc8cze7jxORFNcpQ35B2As029xQgjicEllb/t2lNUO20y+O9NdTOSQpU2ukuI8It2
         PdKpbIVUW64uiIE3J4hTOso9NyMCn6AjHCpJHztTO14qKdqHpIVdozjXbkSbh1oYr/pQ
         X0ovysvV13GnfrBleUsGx/kcUAIjnGAwUBn+Uwo7bbiEXLr+bJGxaraWQ8DJUf5r1L3a
         krz65dgPpeitANj0Mn3v9gDieIxTg9kTh23KJ9UIe/JaNqdgy7/5Ds7NRI0OW1OhuwiR
         vEZg==
X-Forwarded-Encrypted: i=1; AJvYcCXhs+1J+YSXNC9/NtUBmZP9my1bnF84WJpNOdXTfFrvxa3C0ke2IaB0WT6jFQo0m9DHj6pSi8FW@vger.kernel.org
X-Gm-Message-State: AOJu0YwpVnJXEs6FMlH0U1w4UuwpzwCkLoGoa3qvgXdCWau5cRZrtKKn
	wlp0thSSV68CWHeQM2Pg0dxI64L8VzfmS3UBIysE/Ot4IBe9vBbXrleGmfpOgxQ1V+A=
X-Gm-Gg: ASbGncvxW+ERBOdHTJJZJ5N5pdUof5scR+zXXo/FnRMo0gIcQBdJDLounPSHoUg2T8g
	p+LgsGz8jINUVTSEC6JQOpzPxBH5t6gy5Xgt2NuUC2wrLw7R5ra9vAiqIvQ0OBwdRJGbWLGT0aK
	2Ll7D4YLJBYX1I5Q9Ct3kGcNV520lrcXRNjpNPnDVJnABprQT2ORQiPxRZBchETM6S24otlRRMr
	wcfH8syNRlvOrq4NLTjrh+7y7fnSmHwKRyhlQPTXKM0m/aSB/yTEoZXS+csrkulkKQggd1foRHN
	v4VEsidBgJTqn4zWhyUmuRVlVHTuDMMpFCEiuxPLphjtgm8jqCwAWys4yAazxNX1VvfO2fxy843
	HVHhuiU1ByVfNqQjm7bzoKg5DQd93gCiT3Q==
X-Google-Smtp-Source: AGHT+IHv8Ydnb9rIz0+NFvQxdeTcfROor571HxVvcaI2WdRaXpfHr1+DeTmXjRTVXNKfWFeK2MsapA==
X-Received: by 2002:a17:907:707:b0:b24:6396:c643 with SMTP id a640c23a62f3a-b3028427c9amr256596166b.23.1758637068030;
        Tue, 23 Sep 2025 07:17:48 -0700 (PDT)
Received: from localhost (109-81-31-43.rct.o2.cz. [109.81.31.43])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b2aaeea5a1csm621323266b.95.2025.09.23.07.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 07:17:47 -0700 (PDT)
Date: Tue, 23 Sep 2025 16:17:46 +0200
From: Michal Hocko <mhocko@suse.com>
To: xu.xin16@zte.com.cn
Cc: akpm@linux-foundation.org, shakeel.butt@linux.dev, hannes@cmpxchg.org,
	roman.gushchin@linux.dev, david@redhat.com,
	chengming.zhou@linux.dev, muchun.song@linux.dev,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	cgroups@vger.kernel.org
Subject: Re: =?utf-8?B?562U5aSNOiBbUEFUQw==?= =?utf-8?Q?H?= linux-next v3
 0/6] memcg: Support per-memcg KSM metrics
Message-ID: <aNKsCm-SUaxtq2Cl@tiehlicka>
References: <aNEG5W0qLPKKflQA@tiehlicka>
 <20250922173158997VPIUgFcs8UoazWb_JQIc9@zte.com.cn>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250922173158997VPIUgFcs8UoazWb_JQIc9@zte.com.cn>

On Mon 22-09-25 17:31:58, xu.xin16@zte.com.cn wrote:
> > > From: xu xin <xu.xin16@zte.com.cn>
> > > 
> > > v2->v3:
> > > ------
> > > Some fixes of compilation error due to missed inclusion of header or missed
> > > function definition on some kernel config.
> > > https://lore.kernel.org/all/202509142147.WQI0impC-lkp@intel.com/
> > > https://lore.kernel.org/all/202509142046.QatEaTQV-lkp@intel.com/
> > > 
> > > v1->v2:
> > > ------
> > > According to Shakeel's suggestion, expose these metric item into memory.stat
> > > instead of a new interface.
> > > https://lore.kernel.org/all/ir2s6sqi6hrbz7ghmfngbif6fbgmswhqdljlntesurfl2xvmmv@yp3w2lqyipb5/
> > > 
> > > Background
> > > ==========
> > > 
> > > With the enablement of container-level KSM (e.g., via prctl [1]), there is
> > > a growing demand for container-level observability of KSM behavior. However,
> > > current cgroup implementations lack support for exposing KSM-related metrics.
> > 
> > Could you be more specific why this is needed and what it will be used
> > for?
> 
> Yes. Some Linux application developers or vendors are eager to deploy container-level
> KSM feature in containers (docker, containerd or runc and so on). They have found
> significant memory savings without needing to modify application source code as
> before—for example, by adding prctl to enable KSM in the container’s startup
> program. Processes within the container can inherit KSM attributes via fork,
> allowing the entire container to have KSM enabled.  
> 
> However, in practice, not all containers benefit from KSM’s memory savings. Some
> containers may have few identical pages but incur additional memory overhead due
> to excessive ksm_rmap_items generation from KSM scanning. Therefore, we need to
> provide a container-level KSM monitoring method, enabling users to adjust their
> strategies based on actual KSM merging performance.

So what is the strategy here? You watch the runtime behavior and then
disable KSM based on previous run? I do not think this could be changed
during the runtime, rigtht? So it would only work for the next run and
that would rely that the workload is consistent in that over re-runs
right?

I am not really convinced TBH, but not as much as to NAK this. What
concerns me a bit is that these per memcg stats are slightly different
from global ones without a very good explanation (or maybe I have just
not understood it properly).

Also the usecase sounds a bit shaky as it doesn't really give admins
great control other than a hope that a new execution of the container
will behave consistently with previous runs. I thought the whole concept
of per process KSM is based on "we know our userspace benefits" rather
than "let's try and see". 

All in all I worry this will turn out not really used in the end and we
will have yet another counters to maintain without real users.

-- 
Michal Hocko
SUSE Labs

