Return-Path: <cgroups+bounces-3669-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C56A79306C4
	for <lists+cgroups@lfdr.de>; Sat, 13 Jul 2024 19:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 816ED284C99
	for <lists+cgroups@lfdr.de>; Sat, 13 Jul 2024 17:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C8013D26B;
	Sat, 13 Jul 2024 17:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TQaWdgOZ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B37413BAE5;
	Sat, 13 Jul 2024 17:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720892581; cv=none; b=IxM+c8TyOMTcjPdtl1dLcnh8H0xN00uaruxyH/lgFpgx+IVniHBPp2YULLzqAeo3YbHQyhUECliycIOdVryUgB4tb8KnACpBbiKMB5o7bYHvywJJBvqJMa7w70wwz8uM1E7Hai+M90Y9tki2whgVBaMh5McUqDu4jVK1Ia+7Eu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720892581; c=relaxed/simple;
	bh=p4oMqq1JZ9cfHuD1llsoPAD516HrcGSHzwZqStz7d5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QDwYRBi+VV/3bBXCYRFW0FftXYOIPfsiMky7JLG0lmt6pb+qh6YI5cQj+UrPT2J1up/ZOIz7D+tz9N5dt3HQqVFq1viYlbDLgRCqEUCeKRlf8dzEsVkW7IggfC0GNZWBwQu/ZrRPWVsg4Iln7kbjhyQ+8FVBOBYd7oKH3l0Ot1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TQaWdgOZ; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3d9306100b5so1980245b6e.1;
        Sat, 13 Jul 2024 10:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720892579; x=1721497379; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=95I0f6GWE8lEqcaH7kdli8SkufSlTgLIeZA6k+udEmM=;
        b=TQaWdgOZUPURXCZ4VeFpRDW+nLeYXAT9UJfvyAlpmb7lHkwSiDhqumhW2choD5KW0F
         k8MtjO88Nhj63fc+/C/gyNXTTCAYWglwufsZhO83mdme51eeeg30ImJM+lyqLc5+ewjM
         dj137hnADZADAVF4mc0N9tLRe8FFvgLwufiVhn8Tf+W56T6LG24LXKO/DYlbrN/RNkqX
         A4q1Yfp73ca+bGqdlaRefgKY4QL82jtdVm/KZO0ocAn+7412a3ufflQyt5pe4eLX1WU/
         sfqTgnMci+aRrhmpuIl/KbRwHlsb7GycQGfMyJJjKMYlmTbFnMtZw1Ii6YdxRxzqVGyW
         zBJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720892579; x=1721497379;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=95I0f6GWE8lEqcaH7kdli8SkufSlTgLIeZA6k+udEmM=;
        b=LKk8ZD6leN6eLMNOHW4s1iMsP4/jxKaRo9DtRlFmQSXImebmQfnwNB2lNlqqN3F4qp
         3s5MMXdDTACfIEklSDJHBOOhclwES7IXaAoOiJcLHzX/vSkLuciYIX3LFcdbEV90rCqr
         fu313jTWaVD36gExF74/Dw5HyZzkgHg1MTozARnQPDHa5IkLcmgTN6hv/CdKU1iN/wnR
         uc13n+OZmVZ7bU2nM9oGLi0BeVW8mfAKlfDNnVzITkv/BoghmsKCQzBEz+yY/fx3IBiP
         60On7tfeZNE4BomXLwMNogTZ6tgDFoLo19o/5wT+BePPTCdggwd0mQ4Vz2XbrJFqzf1W
         JszQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbSp48R0OISe9KmSj3YyTcfyHanAb6lbb9S9JC1doBEyDs2s6sy0SFHyQqA5WSvS8n625WEwmpC0NjN4f+4W/lOdaUoxwW14AzMrvoptlUELZIeee6X2CMTRY9QNxFsbxufUmyCw==
X-Gm-Message-State: AOJu0YyizEhvdJnZrkh8lVQeccZgj4qnPQwoi5hNWSXIyl03IL9+OT4u
	oOhy61mXLJjiG7xIT2dtC/ZNrCJPyWub6tLJEuho8HL5QY4ya+8VfFGydw==
X-Google-Smtp-Source: AGHT+IHcdM4gB0n7tVsEVJW3HHBfuE6eiec2yU9PD7j+tZS/lt5S9sTVmJ54qss3PaxIgNCtVOYv6w==
X-Received: by 2002:a05:6808:1795:b0:3d9:2a77:b81b with SMTP id 5614622812f47-3d93c0405fbmr18756154b6e.34.1720892579194;
        Sat, 13 Jul 2024 10:42:59 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7ec7d0cbsm1471403b3a.137.2024.07.13.10.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jul 2024 10:42:58 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Sat, 13 Jul 2024 07:42:57 -1000
From: Tejun Heo <tj@kernel.org>
To: xiujianfeng <xiujianfeng@huawei.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH cgroup/for-6.11] cgroup: Add Michal Koutny as a maintainer
Message-ID: <ZpK8oaC-tvI92Nc8@slm.duckdns.org>
References: <Zo8OzWUzDv3rQIiw@slm.duckdns.org>
 <bd583161-edc4-bd43-5a11-7e6707a60f5b@huawei.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bd583161-edc4-bd43-5a11-7e6707a60f5b@huawei.com>

Hello,

On Sat, Jul 13, 2024 at 05:23:20PM +0800, xiujianfeng wrote:
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index d6c90161c7bf..3dd70792f572 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -5536,6 +5536,7 @@ CONTROL GROUP (CGROUP)
> >  M:	Tejun Heo <tj@kernel.org>
> >  M:	Zefan Li <lizefan.x@bytedance.com>
> >  M:	Johannes Weiner <hannes@cmpxchg.org>
> > +M:	Michal Koutný <mkoutny@suse.com>
> >  L:	cgroups@vger.kernel.org
> >  S:	Maintained
> >  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git
> > 
> 
> When I use ./scripts/get_maintainer.pl to get the maintainers, I get
> this info:
> 
> UTF-8 "\xFD" does not map to Unicode at ./scripts/get_maintainer.pl line
> 385, <$maint> line 5656
> 
> "Michal Koutn\xFD" <mkoutny@suse.com> (maintainer:CONTROL GROUP (CGROUP))

Yeah, the same issue triggered w/ doc building in linux-next. I applied from
email copy and it re-encoded from utf-8 to some iso encoding. I fixed up the
cgroup tree and it now should have proper utf-8 encoding.

Thanks.

-- 
tejun

