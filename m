Return-Path: <cgroups+bounces-5056-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3828B993EBE
	for <lists+cgroups@lfdr.de>; Tue,  8 Oct 2024 08:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2A442857C7
	for <lists+cgroups@lfdr.de>; Tue,  8 Oct 2024 06:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C291F18BC3A;
	Tue,  8 Oct 2024 06:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NZ0OTjUS"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4336C17C7C6;
	Tue,  8 Oct 2024 06:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728368368; cv=none; b=PtZsOmhS2obuRycIHTgF4PF+LntwxVZHfw8dRY7jsw3CzWy/7LzjuIg/+tWcWYyswxr8nqLFE9lDZqKuBWlnWFKXHOopa9uc3O9TyK8ngUlF3RKnyoq70C19wNVHDmCjIIbwyvUjMHDtjZi45X7ppn7euglwupvXjhmKopwzAeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728368368; c=relaxed/simple;
	bh=XIXJA5CIAPoAB8tcE4ZYSl7tqzNOJcvqYDc7gIbAe4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GL81NjWhyK4pRD0eNpxV0596YVHF08H0i1BbBwSa+rQCPCM+gVueFwFawsd/qJt23j3K0Enly1usCmpABn7hBYXcMHgzCRGB7fAISMUEN74TvzoRenicVAHTQKZTQ4acG27Tei/FyJIJilulIP0OGVHgmpUPEVcjy6BgzVHLmgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NZ0OTjUS; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20bc506347dso42142495ad.0;
        Mon, 07 Oct 2024 23:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728368366; x=1728973166; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EHxXhz7bzsxtMK4NRPqKJZF+dplL5x2geusUM8K+bKY=;
        b=NZ0OTjUSPsaGX3hhBlAWrATOFwcQn7KqxdMp38o4WrkyaQ6sbusDf4CPFo1ZJenhqX
         cJKO2o6yTUQONQUGRiGdTLXRZFWm7gNWH7pstIaKIj3CXbHWp7gnw57PAcrfYYng0mCH
         RP1O1SaSvK+FaxxlG2VRD1MbTjD7xkHCxz9L0W1L1EalbJEopGtpObyggmJ/k2DFy7bE
         s6X/N2+e7tmyXGTnGvkCKFPnMCtBG65+noQ6HQF3omkLBGwwyyaSQLYyX//GqpomX/R5
         agYmScJ8XaS9n/sjIs7m2us3+2qJQBKqSmEb0rwtR03lEnFRwIcfXfNRQOGkWDyLEIM7
         ZmKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728368366; x=1728973166;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EHxXhz7bzsxtMK4NRPqKJZF+dplL5x2geusUM8K+bKY=;
        b=HcrxacqkEi2iKAnK38Ji3zNh7TaHLmmO70r2zQ7U1zRRqE+cyi3Xb9t+9SLES6RUVR
         Qfy8fU8jLSTUixve4voeLc0wMLowjsEIYRDEa09SOQKxmxsqMfzrq5dj5oRPwtboVaT2
         zB3NLDK8nflqHUMn8x/PEBannc1eCgvq6+gfirtIx+bJwi6rZ/In12ya54Hc2Dq2WOU1
         yq1QMnOTPVa85lM6PmhBZIQMcKDbvHdxiV8fGpikpG0i9YH8JA7JGC5EWtgeAlhXZEP3
         eVWFF94ZOU/9YWx1+pvkhCCg9eKzF4XzEWbJoVpQDEgDEdcXne0nXsdTQN1LhFiVUkWh
         LCZg==
X-Forwarded-Encrypted: i=1; AJvYcCVDeOYxq50g3L44LohK3gjj9CBCGjmloLbFHzvXWAv0RCQaKjfTSW3RKwK+qLfE/yEUpfa+IpiACANZQUWs@vger.kernel.org, AJvYcCWeDRYsawIvQhySmsu9JwNUrKgTf0+FwxqiEPx5ynDyFO+I1G9fHt1vEgLW01DFE2mFo9TnfQQ1@vger.kernel.org
X-Gm-Message-State: AOJu0YygXiG3iRYpQF2tEdGebqGMKI3XGtrobHljUkOA0r3faEtW3abS
	WT5yji8YTbSb6mByXgawu6kMLLAqjfGOkS7dwHTBPhcmpeboeHpx
X-Google-Smtp-Source: AGHT+IFIYkVl3l59m2WMG9V6/zmfFRCN95pbOrzkqA+oh57ATV9A3W4zdKyFTbVKdHYg8OqfS41nEQ==
X-Received: by 2002:a17:902:da8c:b0:205:861c:5c4a with SMTP id d9443c01a7336-20bff1ea9e7mr175220335ad.60.1728368366406;
        Mon, 07 Oct 2024 23:19:26 -0700 (PDT)
Received: from visitorckw-System-Product-Name ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c138afc71sm49222065ad.47.2024.10.07.23.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 23:19:25 -0700 (PDT)
Date: Tue, 8 Oct 2024 14:19:21 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Tejun Heo <tj@kernel.org>
Cc: xavier_qy@163.com, longman@redhat.com, lizefan.x@bytedance.com,
	hannes@cmpxchg.org, mkoutny@suse.com, akpm@linux-foundation.org,
	jserv@ccns.ncku.edu.tw, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org
Subject: Re: [PATCH v2 0/6] Enhance union-find with KUnit tests and
 optimization improvements
Message-ID: <ZwTO6c8fapOdGXGi@visitorckw-System-Product-Name>
References: <20241007152833.2282199-1-visitorckw@gmail.com>
 <ZwQJ_hQENEE7uj0q@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZwQJ_hQENEE7uj0q@slm.duckdns.org>

Hi Tejun,

On Mon, Oct 07, 2024 at 06:19:10AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Mon, Oct 07, 2024 at 11:28:27PM +0800, Kuan-Wei Chiu wrote:
> > This patch series adds KUnit tests for the union-find implementation
> > and optimizes the path compression in the uf_find() function to achieve
> > a lower tree height and improved efficiency. Additionally, it modifies
> > uf_union() to return a boolean value indicating whether a merge
> > occurred, enhancing the process of calculating the number of groups in
> > the cgroup cpuset.
> 
> I'm not necessarily against the patchset but this probably is becoming too
> much polishing for something which is only used by cpuset in a pretty cold
> path. It probably would be a good idea to concentrate on finding more use
> cases.
>
I hesitated for a while before sending this patch series, as I was unsure
if these optimizations were worthwhile. As you pointed out, it is only
used in cpuset and isn't in a performance-critical path. However, since
the union-find implementation is placed under lib/, I thought this
suggested an expectation of more potential users in the future (otherwise,
it might have been placed directly within cpuset). These patches might
eventually benefit other users down the line. Additionally, except for the
patch that adds kunit tests, the rest involve only small changes of fewer
than 10 lines each. That’s why I decided to go ahead and submit them.

I agree that these changes would be more meaningful if more users could
benefit from them, and I'll try to explore further use cases. I understand
maintainers are busy, and if this patch series seems like unnecessary
changes, I apologize for any wasted time.

Regards,
Kuan-Wei

