Return-Path: <cgroups+bounces-7695-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CAA2A95A49
	for <lists+cgroups@lfdr.de>; Tue, 22 Apr 2025 03:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D900B3B5857
	for <lists+cgroups@lfdr.de>; Tue, 22 Apr 2025 01:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226184EB38;
	Tue, 22 Apr 2025 01:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="BEwDMatC"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C989134BD
	for <cgroups@vger.kernel.org>; Tue, 22 Apr 2025 01:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745283654; cv=none; b=io0EYLaYBA9dzk12krW68bdTT8ivVsEaoURRWXyjkMXq48jTeB90gyPOZ6MDxufJfigTySFI+WPWTBI2JIzj61OvYymwq7qtwYgeSUTTezccpmxhhFRK7NFI5q2hlMXlODUsa0Zs864OjAGnina6NQ+RwTnUUNIeOlpq/teXoqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745283654; c=relaxed/simple;
	bh=FN7ge8ZWEGnky0XQuK3P4oUFlqdduIuV6SgS3RSb5/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ql940Mgr9Gf+/w4rmnH62lhzeVGeaAGrwC0B2xh0ODvgHKcOnVj+1deVFLlXYZK8x47m0p+UJSxXpN4Z7j8SiDDOLDvUMZpfiXlN94VnV+dtUsh0lCIKSjNNKXc2ibOQyS81FUqBoH2QPRrH2MnC2Rg/9fB8A4LhR6NERKmmeI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=BEwDMatC; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c53b9d66fdso626199885a.3
        for <cgroups@vger.kernel.org>; Mon, 21 Apr 2025 18:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1745283652; x=1745888452; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=90WqYzTUohl7lOp7C5Tba3PcsVTn1W7MH0EIP3L7DLY=;
        b=BEwDMatCYp2bbPf6cZNS5KBBKX5WFqRArTrgCZTzeBvVWNW2ChH7ux1EQsAdv0vNmD
         sm/x5e3OJe2Ghxcr7rwbKN0DPa6eUAu4XBEv7bSGTOxlqQmeg0PPlDfANBmGxuEWIsTQ
         9nQbukoHnhOUrymCHXiC3EAnHDIRPJUwXahdQaMfIdhPzmjwZkCqwkP6pxvK7bDRuaDG
         xMASv/rYV+dmjr2NNnj+Vda7bBdSS149mW6SXnkfywY/YGLy8YsnS5u4zKTgnnEN5Yo8
         i0htkLtx9RHs02c/NkTKgXhmngXUlOTIx9gXKPqCeInggE45vvvbOKGUgZVMMlSIMp6N
         /fjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745283652; x=1745888452;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=90WqYzTUohl7lOp7C5Tba3PcsVTn1W7MH0EIP3L7DLY=;
        b=o7EiGiNf11r26OZ3oHB9nsKl1rZ04inkLHpkDIgGLqyk1Dp169M66HwmbYhzbem2/p
         306SI0g7qVZqk5S3cn/eZFhhhlHhn85wqptMWPEe0BnOmh89zu1SJgF2q/DWl+RRKmFb
         j+wXGnaN/4G/Bh+bPD3WAGUwaGZlRqkGOF0ImZkzajhZOUhwcmaHAizJXI2pFy5UMca3
         SiXzkSSzEhJOV7XSSWt0lHuAqMREcU7vdU/H5oeS5ro4/7lbyogxtAb9XwS26LD6iniY
         3JKhic277wWMn4QtygS/dp9xq5vTbCfNIacQtE5OdTTVhCDhFiVq5+MB4JAkHj3+KdY4
         MGww==
X-Forwarded-Encrypted: i=1; AJvYcCWtqOEXr/UUx6xybuEmYw601wNElWOyac872eqRRrtkn4R9WljcG/Xd4Deslje9kSiD9rr32ctv@vger.kernel.org
X-Gm-Message-State: AOJu0YwpcLzNBq5bZ7pAFsCfyPKD9nP5hzYSgI0lXUlBgVFpafdKVfI9
	i9Esr993bEq3jvdQU8yh6aSNvg4v8G07jmhywFpV9lqgzRwDgYOckRddUAf3NnI=
X-Gm-Gg: ASbGncsU6O0kcMEQmihkVIHGTbRsPMkKBOAI60yTH8ZGt9iVfcfoHYoO96PgKq4Y1JN
	Xia8/wgaZ1lM0NQGpTdpWLWb3XR9hraXRqHONw+NAAPh7oQGzyCXEn3R6zQfFHYZukznophRKLe
	/x6M18USoamcq+VV6PQ36RgjrujnxOmI7WMPCydpm1JuQh8RGKaSXhyKNf+pPo2XIWKEXtqk8GV
	/tMPgcxWIEYGzRLYWLUs4KAC0+VQfZU593GvXv6LtW0mia0cKGMl0Fb9/m6uH3xeOGkL82CXNjB
	rN1iVn8TOST6ociqAQyPc6SwtoFPmONhLlHz1LdypNuEMHcY2VFOI/nOIDqKqPan/PQtvFb2Awu
	HP14bTB2qmc2x44m1LIZ5z78=
X-Google-Smtp-Source: AGHT+IHiMCQ4CKaumf1ZfYJE8F7xvKHLhb4koX3kikt1CtQaYhbu+kCRWDD9oQA1oGd7re3S+fS3Og==
X-Received: by 2002:a05:620a:2588:b0:7c3:ca9d:210b with SMTP id af79cd13be357-7c927f67bedmr2112823885a.6.1745283651624;
        Mon, 21 Apr 2025 18:00:51 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c925a6e7casm486458085a.10.2025.04.21.18.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 18:00:51 -0700 (PDT)
Date: Mon, 21 Apr 2025 21:00:49 -0400
From: Gregory Price <gourry@gourry.net>
To: Waiman Long <llong@redhat.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, hannes@cmpxchg.org, mhocko@kernel.org,
	roman.gushchin@linux.dev, muchun.song@linux.dev, tj@kernel.org,
	mkoutny@suse.com, akpm@linux-foundation.org
Subject: Re: [PATCH v3 2/2] vmscan,cgroup: apply mems_effective to reclaim
Message-ID: <aAbqQXJFCIb3Mscq@gourry-fedora-PF4VCD3F>
References: <20250419053824.1601470-1-gourry@gourry.net>
 <20250419053824.1601470-3-gourry@gourry.net>
 <ro3uqeyri65voutamqttzipfk7yiya4zv5kdiudcmhacrm6tej@br7ebk2kanf4>
 <babdca88-1461-4d47-989a-c7a011ddc2bd@redhat.com>
 <7dtp6v5evpz5sdevwrexhwcdtl5enczssvuepkib2oiaexk3oo@ranij7pskrhe>
 <aAbNyJoi_H5koD-O@gourry-fedora-PF4VCD3F>
 <ekug3nktxwyppavk6tfrp6uxfk3djhqb36xfkb5cltjriqpq5l@qtuszfrnfvu6>
 <aAbbtNhnuleBZdPK@gourry-fedora-PF4VCD3F>
 <6e7806a7-9ffd-4c7c-b247-934b206088c7@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e7806a7-9ffd-4c7c-b247-934b206088c7@redhat.com>

On Mon, Apr 21, 2025 at 08:35:15PM -0400, Waiman Long wrote:
> 
> Your current patch is ignoring v1 as css will be NULL. It only works for v2
> with a unified hierarchy unless some users explicitly force cpuset and memcg
> v1 to be in the same hierarchy. You can certainly ignore v1 by using
> cpuset_v2() check.
> 

I'll whip this up and get it out this evening.

~Gregory

