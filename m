Return-Path: <cgroups+bounces-12573-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 542CACD4C7C
	for <lists+cgroups@lfdr.de>; Mon, 22 Dec 2025 07:16:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6D065300BCC0
	for <lists+cgroups@lfdr.de>; Mon, 22 Dec 2025 06:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45A0327207;
	Mon, 22 Dec 2025 06:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yybZ+PW2"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35666326D5D
	for <cgroups@vger.kernel.org>; Mon, 22 Dec 2025 06:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766383808; cv=none; b=kUSWiuyLc9+GrOQbqzlyOPBx2DjZ0dIM5d6nobTc7T633povloGD13S6aE6WynjKT1Jo3+ysiF6WgOoCe2vPK0MADme4dGtytQjAbYfrvQep4diRZ9JjPicwRpNOvNbXpvAKX+e8e46f8bipuaHn9IWfarbKAYorSduLKcU5DWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766383808; c=relaxed/simple;
	bh=2ZLm6y+vDWz/IlruQLkF1a1UAxU3uOV5Gb4PE6qBNwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=syS8aILlzb/x7/GlWV63PYLZNLMSLiYg3II7elWcgh9IYjqZT8aMMJd2R0wQ7INWfWSe5I29hZdOO3wzKIL1e5Slx5cijd6gzRx6N6Mt7PwzrIO80OoxD/y76SCLuMdq9H1wRVKkYpJ2k+NXvBY4N0WmfgAS7q9U+4eDHUWZkJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yybZ+PW2; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2a0d06cfa93so419255ad.1
        for <cgroups@vger.kernel.org>; Sun, 21 Dec 2025 22:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766383805; x=1766988605; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4d4yIf4cTLhpX8RECsjI9Ii+PJ5wkNjuQ9k20d0TZc4=;
        b=yybZ+PW2uQU6MJQwtRiooTXlyb4Rd/KQXuFSxfO5dAz7Rm3ljQoylFQj7jQdWb2i+l
         Dxx7CjISy1DPMXeWYtDgzB8FlbGYmwdv7TnrfIcGi/4P1193oUnvkXGatCHSBkHUulsF
         vSX+80FnKBXTUwfCJ59idlww7Pjd+P8MuQ9DJbnhns4vUZ/v+SuG8ri4YO/uFBpxZp1i
         s0Y5Y/JT4k63/LuLov369fL5NW4NpOdQa4VUxZ/H7CQYSiGmLYgdqF5UCVuO8Qq3gii3
         ZM3gT03YAvi1395nbRL6hP0r9hRsbe3qJR+ApxlcWtgu5TWK+ECwbVIfn6Tob+kelYFf
         VXbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766383805; x=1766988605;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4d4yIf4cTLhpX8RECsjI9Ii+PJ5wkNjuQ9k20d0TZc4=;
        b=StIl3QQfckLTyxnN1ghWMMTLcJNIKjvID8YfYoE0UwlqNy65pNly8Xwf8Kw8uPP5Ad
         KOy7MiisPkWiRFexFZHVlPG/nkgz39TsIR53BxlwlJY3C5jzW3DW8lxqjpVfejerQKIu
         u17NW0Be2T82kPLerzHDdctU0UA5EnhIaNNZ5vzaRPYNXDKDGPM51wKSIcrjE1YsBJkV
         9ZPtBLRx3s2W5Ak6vbhxCr5o/h88AHRuDWd+lM9lPuX/Lr6obAx2bVQvHu58CoVVt6QI
         P/dZJvfGe4mtu1+73A35YfoxwTwqZX07R2qEICd2JFOuFUAtIMcgrxvsb2Vu1M5vq0iX
         X94Q==
X-Forwarded-Encrypted: i=1; AJvYcCUtHG/DizNFQKmn8qY0zLnCm7Y6LsV+mRnPdORPjlNVbREQVzPnvWCino5k38CP2AcP+3cCg31u@vger.kernel.org
X-Gm-Message-State: AOJu0Yykaa/nvQ367QWjDh1Ak1m+p9O9/2bAGntKyKy2j5BpS0ICOqMv
	6PclfVfHV13tkIumVoFMqlLfLZpC3cCRt+GS1BkeEwxJ5K9o//oIk6YgdiwazhBAiw==
X-Gm-Gg: AY/fxX5XN4q9ez6k+RApBs6ub07SxCf7vVssI1ytuaXCiWsreu6sRSt6NzozIFjt7Xf
	P9Mdefw8dzCz15HXdSyFxobxFYNlVK19vhpYgRuLfKihEIStgPDreFl+rFhH8QaYaAOcyHWv5Vv
	sC7cEGmWLfUHeu2XnEoQHcOLZ4r5bSV+iuADTU5gpbJKtnwZ3Uju2K0y2yUGZuaBT62awSelMzt
	08P47exTFODQUYL4DouSsGHeDHEaIuBgjdNJyzrLbXyHCskEhqL7fxPvArg1K9NEjMiZFfEHJBr
	zWvchrAH1GljlJ8fZv3C+XjYgSkhKdtpcnnYepEq6F1qrk5pXZ/VRn2ckCE8ezdmLmJqvuC+GrI
	naWOD184VoJOKCwilngpu6mUAYSo3maSLbqIGA0hEOQptrQgJu57YKgKGCtMElK/K38n7294V7l
	Y6L/R3FJuAzP83ZOjCNAMILaR1WeBld/Ld5qrfuu6W/YIGCSMkIpRd
X-Google-Smtp-Source: AGHT+IGJHMHvQ2BiL8kGi+L1NEiyq9evaHsD0bUwM82dYISq+7N3XOj+vRLmNpWXWMhfzBHm5bRjRg==
X-Received: by 2002:a17:902:e788:b0:2a0:7fac:c031 with SMTP id d9443c01a7336-2a311806e37mr2693085ad.14.1766383804712;
        Sun, 21 Dec 2025 22:10:04 -0800 (PST)
Received: from google.com (248.132.125.34.bc.googleusercontent.com. [34.125.132.248])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7e48f30bsm9091090b3a.48.2025.12.21.22.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Dec 2025 22:10:04 -0800 (PST)
Date: Mon, 22 Dec 2025 06:09:59 +0000
From: Bing Jiao <bingjiao@google.com>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, akpm@linux-foundation.org,
	gourry@gourry.net, longman@redhat.com, hannes@cmpxchg.org,
	mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, tj@kernel.org, mkoutny@suse.com,
	david@kernel.org, zhengqi.arch@bytedance.com,
	lorenzo.stoakes@oracle.com, axelrasmussen@google.com,
	yuanchu@google.com, weixugc@google.com, cgroups@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mm/vmscan: check all allowed targets in
 can_demote()
Message-ID: <aUjgt4EdBv4UyrTM@google.com>
References: <20251220061022.2726028-1-bingjiao@google.com>
 <20251221233635.3761887-1-bingjiao@google.com>
 <20251221233635.3761887-3-bingjiao@google.com>
 <d5df710a-e0e1-4254-b58f-60ddc5adcbd5@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5df710a-e0e1-4254-b58f-60ddc5adcbd5@huaweicloud.com>

On Mon, Dec 22, 2025 at 10:51:49AM +0800, Chen Ridong wrote:
>
>
> On 2025/12/22 7:36, Bing Jiao wrote:
> > -void cpuset_node_filter_allowed(struct cgroup *cgroup, nodemask_t *mask)
> > -{
> > -	struct cgroup_subsys_state *css;
> > -	struct cpuset *cs;
> > -
> > -	if (!cpuset_v2())
> > -		return;
> > -
> > -	css = cgroup_get_e_css(cgroup, &cpuset_cgrp_subsys);
> > -	if (!css)
> > -		return;
> > -
> > -	/* Follows the same assumption in cpuset_node_allowed() */
> > -	cs = container_of(css, struct cpuset, css);
> >  	nodes_and(*mask, *mask, cs->effective_mems);
> >  	css_put(css);
> >  }
>
> Oh, I see you merged these two functions here.
>
> However, I think cpuset_get_mem_allowed would be more versatile in general use.
>
> You can then check whether the returned nodemask intersects with your target mask. In the future,
> there may be scenarios where users simply want to retrieve the effective masks directly.
>

Hi Ridong, thank you for the suggestions.

I agree that returning a nodemask would provide greater versatility.

I think cpuset_get_mem_allowed_relax() would be a better name,
since we do not need the locking and online mem guarantees
compared to an similar function cpuset_mems_allowed().

Best,
Bing

