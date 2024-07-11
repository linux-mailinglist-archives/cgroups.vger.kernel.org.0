Return-Path: <cgroups+bounces-3637-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 589D992EF8E
	for <lists+cgroups@lfdr.de>; Thu, 11 Jul 2024 21:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C6431C2200D
	for <lists+cgroups@lfdr.de>; Thu, 11 Jul 2024 19:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20CF216E88D;
	Thu, 11 Jul 2024 19:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hbuyTOqT"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8817D450FA;
	Thu, 11 Jul 2024 19:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720725706; cv=none; b=OvXrXZjRUvO3wU2zY6QaHSSLl0UpBzxAf2y0VwqeA2Xwaz7x14w9f0eUZI7aEVVHRv+HxsqQXer5bvErNv5lrfxfDWyJKVETyCm1GxNr4ag3tlHTpDrEKpb13Tm/8x1c/XHGx6MuNWZeh4CBX6h4HGwOMzrHB58EXBW4teesm8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720725706; c=relaxed/simple;
	bh=fw4YxU9DPg/09cxxvjQAAiL0/MXAP2kW8a5griN92rg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Psfqrt5fczOfM4L6/r4R+VgFv7ZakxL2gltpyyOW1SaNXV6GDH/LlzMP/hlFZJ5MN7U99TXGeEueQL0GCRccdM6XdgKjYtAe8U6c2jencCXJqhW3nKM7Kciv2m2ol1N0/s8ks8cxaWlT5Z5FQl739ab72L9hG1ldZUlrSGfcrQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hbuyTOqT; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1fbc0a1494dso8725985ad.3;
        Thu, 11 Jul 2024 12:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720725705; x=1721330505; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MWrdrdY+AbHhwYGUF4k8vyBspATH5/TSpWx5tvkKe7Q=;
        b=hbuyTOqTkPxdaylbE866pRw8uo4xU8oI8XO6C6xrawHW6AY2T72G0Q94FCbygs9sAA
         47taaRP5eDVeqcSpxAFiTGQ0G4XrmwZnw5IncXgcN/CWgb9M3d5h2xNGfMkQjUcIpQNy
         T4tjHFYIz1yBmAjesM3jFtktpkX6UIrOyVfIkjvoqydSJwChY1oH4qZxIoMZzKb9VBs3
         Re6n2annlMXQjigLcYCfd9BiHekHhOUreSpOLTnAi8LNkDMj2ZDh+x7YBFVQP/PvSHKz
         pbOPoS5nurYxNWwtu/1F4eb23EQiyoq7yPt2DHxEssj07LruMynobCQntFT48mDl6v/v
         nxIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720725705; x=1721330505;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MWrdrdY+AbHhwYGUF4k8vyBspATH5/TSpWx5tvkKe7Q=;
        b=AmK6XjuNpiCwC8rBqwD9fDSLpVpVwzB73rXuED5ATdi9tpe1yvjKBPr5WRAU4q2MrX
         iNrvCsR87gILacK/lF2PmrKdGwR+47tWsy7kPl0jFm2dOhfEfuRG0H6RTsU1u5DnEEDp
         gxShXhv2NTf3Iz0ZCa8WY9L84KfuyJgIiH+Vj5N6o9xaUdckNHzByEAoREERSjmgCJEh
         Z1aFi3K+14g/Cdjg1rn7yjvLigLsIdcbzxn53J24+bRly+7yu6VAuXiTX8D35H8AwKVM
         U8UiCC845dmcuDvWw2ahMjaNNAbtDtVnSF9wNH5b80yWm4IYpoZDXpszBvS3DfaoNutw
         f3iw==
X-Forwarded-Encrypted: i=1; AJvYcCXCTEq5JheNKM4zBAN7FEi3kvXt4R91Ey1RmnRgV+iVs9V2oO3IMUS+Y6cNFc804oZyR8QyV+E62qExLvPCYaumCi3bP4gStvXM2+xX/RwHMvw4QZr/Fv4ASk9wcU1Do351DMV1OZFmoLAzigYumukEe5fjLH7uYwEc05O5gqJzIg==
X-Gm-Message-State: AOJu0Ywia+TaqP7BwlI35YVfGg/1yk4YA2kdt6F87Mjb/2fGagIBx2Yc
	9lGxT/mX6844oHjNyHT0y3XEG1HA2KDwRdgxpjrgVrs6he1/bSJ6
X-Google-Smtp-Source: AGHT+IE88lbRrDg58N/X+QvujRkinKh4rLaZ6IM0tXxRjwSSlzV/+Hh4E53wuEvz0FrCYWvqA23nzA==
X-Received: by 2002:a17:902:db0e:b0:1fb:1afb:b864 with SMTP id d9443c01a7336-1fbb6ce527dmr79957615ad.5.1720725704768;
        Thu, 11 Jul 2024 12:21:44 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6a1089dsm55457055ad.41.2024.07.11.12.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 12:21:44 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 11 Jul 2024 09:21:43 -1000
From: Tejun Heo <tj@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Jonathan Corbet <corbet@lwn.net>, cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Kamalesh Babulal <kamalesh.babulal@oracle.com>,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: Re: [PATCH v3 1/2] cgroup: Show # of subsystem CSSes in cgroup.stat
Message-ID: <ZpAwx358QVr4V7RN@slm.duckdns.org>
References: <20240710182353.2312025-1-longman@redhat.com>
 <20240711134927.GB456706@cmpxchg.org>
 <4e1078d6-6970-4eea-8f73-56a3815794b5@redhat.com>
 <ZpAT_xu0oXjQsKM7@slm.duckdns.org>
 <76e70789-986a-44c2-bfdc-d636f425e5ae@redhat.com>
 <ZpAoD7_o8bf6yVGr@slm.duckdns.org>
 <e5348a85-22eb-48a6-876d-3180de5c7171@redhat.com>
 <ZpArhD49OonR6Oz6@slm.duckdns.org>
 <c54651db-1a06-49f6-aea7-02768ad70756@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c54651db-1a06-49f6-aea7-02768ad70756@redhat.com>

Hello,

On Thu, Jul 11, 2024 at 03:13:12PM -0400, Waiman Long wrote:
> That will means cgroup subsystems that are seldomly used like rdma, misc or
> even hugetlb will always be shown in all the cgroup.stat output. I actually

Hmm... yeah, that does increase the amount of output, but I don't know. The
trade-off is between consistency and brevity and I think I'd go for
consistency here.

> prefer just showing those that are enabled. As for dying memory cgroups,
> they will only be shown in its online ancestors. We currently don't know how

So, one peculiarity with memory is that when you enable io, it gets
implicitly enabled together and we likely wanna show that.

> many level down are each of the dying ones.

I didn't understand the last sentence.

Thanks.

-- 
tejun

