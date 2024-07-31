Return-Path: <cgroups+bounces-4044-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 393369434A7
	for <lists+cgroups@lfdr.de>; Wed, 31 Jul 2024 19:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B458C287EF8
	for <lists+cgroups@lfdr.de>; Wed, 31 Jul 2024 17:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC8C1BD503;
	Wed, 31 Jul 2024 17:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QJT/tAjZ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFB91BD4EC;
	Wed, 31 Jul 2024 17:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722445351; cv=none; b=X7hjqbSVxqwOQrXvuvIajjTvIK9+hZObDhU3Iw8p++tRyJqbKB4Wy1SYiqRdK2e/Xa6miRqbnnvA/fhGWlfZt++1fhOVVx1iZpQb5AmAa+j4ulwskUE5ZWDhH6d9MTPOy21RaTsZobTv3gS2suGbJ4zEI0Io73oSqKzjAxjuU3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722445351; c=relaxed/simple;
	bh=c8Ltgw/DPOdU02C582LSHG5lm90+Rm07EJ771Vi5GpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tZ2r/6vLZYQk4axCfnGzNDeiHKa8tA+rDIh6qkh6SQFMDZP1Rnv7lOaqpTfrJpXC0EjCPwgLDoKhqExWSX29mhPJtIOY0WI8rcLHoe1+Bojt0uRAQGSLuGYS/p7a0b+maOFE7EaRqsYfw/jYXPTuG1bAYzrLTnGNapy6WDJcvDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QJT/tAjZ; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1fd69e44596so9254785ad.1;
        Wed, 31 Jul 2024 10:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722445349; x=1723050149; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CdlSb92YdWekG68UtHx/Hvmif5Dl5k6gnXTiIqybP6g=;
        b=QJT/tAjZWbFLs30v1U19jx22v6umz1qPK8HiZBlmKbeOvmmmknLFnX2XdqS0W+k+n/
         d0nlG8eoXBvpV25iddMG+xNdqRBMWjZV31dAPP8JfPnKAw8aR+sEBOikCtCinsurY0e7
         CiLHZ0Olup7B2ipAYUxkph21xXd8xpWE6+JTXk7HrblmmxdzIj6+uNrHQ7DqCm2bjlps
         B1sf1cj9+uf0ElAE3bqknjYke6nxKhjJh9SIf34O2+FXHjJNOgubAsmkUT9Jz3O96+ZD
         67vuTqNjV1xndYbePY5Pfq8mJKtW0ycerfAEQdGCiGTOHq167yK0lItI1WzKtGiU05hh
         cQXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722445349; x=1723050149;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CdlSb92YdWekG68UtHx/Hvmif5Dl5k6gnXTiIqybP6g=;
        b=JG8IYLVwBjYnkKFprZqm0IEjTn7QPw7SRYN41hmi+MHdNAGPxDe6fQITaD/ZuWQTOc
         KZmtc3o5haNSr9A0UJAGtfXZl+z25+lOtsdjijIY31NHf8zCu79pMP7GNT3bKNuWhD4s
         etv6wUb5uUgmLh0l6p1qt4krdZTJRlksV2oZiI4ZEPnfNfR+TF98N/pFBPH0nnd45yty
         KVgAkw//UJ3pCgod5245CZqFox5A94Ypc42+EoLxmAUkBBVjBkeHrn4kKHhEpxDVYTXM
         KOde5djKf98JEZ90JC5wWz5YCYxh6JZwc/FMXAD8qY1CYgm4uPZ5Pa4socWpaK8bXbY4
         L3cw==
X-Forwarded-Encrypted: i=1; AJvYcCW9jtwK89djk97EwvqVZFnE5Z+FWjjXjkoF1sg+mVR0nmjZD8jrIFjeNDZYZsih+QAR9n2vnQNHXOb4Zpk3gHWXJl22qvJNNsQj4mQYquhLbruGVZnSWffeDFFcBndo8ya+J+eLuIKesbD9Cs8wadOENOTMDrSnSid7XGghvOP8DQ==
X-Gm-Message-State: AOJu0YxuKQEtMMbayLaPVfPgv0Hk0E161HN2vnZzo7lTaSSihaJHzgNB
	WBCVz6rRR4lrUhAWkbMClgRLNUd/r6Olx+H34+oIG+V2YuEizF46
X-Google-Smtp-Source: AGHT+IGzP9iZ5bObshHYNlvI7zXr7wwZL6e/ehgLqjD7JV17E6X+9wiBV0YaAT+0S+gd75mXxAW7Ew==
X-Received: by 2002:a17:903:230f:b0:1fd:8f4d:2392 with SMTP id d9443c01a7336-1ff37bbd5f7mr96564925ad.1.1722445348632;
        Wed, 31 Jul 2024 10:02:28 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7f67528sm122287045ad.227.2024.07.31.10.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 10:02:28 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 31 Jul 2024 07:02:26 -1000
From: Tejun Heo <tj@kernel.org>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: Waiman Long <longman@redhat.com>, Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jonathan Corbet <corbet@lwn.net>, cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Kamalesh Babulal <kamalesh.babulal@oracle.com>,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: Re: [PATCH-cgroup v7] cgroup: Show # of subsystem CSSes in
 cgroup.stat
Message-ID: <ZqpuIgdNLLwyjT9n@slm.duckdns.org>
References: <20240715150034.2583772-1-longman@redhat.com>
 <ZqmDpLTm6tKhAmYv@slm.duckdns.org>
 <4cb4bczascgy4w774k7y5z5yewvl4civpkuhl46g73ckvoubj2@ag2cfvgayfqs>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4cb4bczascgy4w774k7y5z5yewvl4civpkuhl46g73ckvoubj2@ag2cfvgayfqs>

On Wed, Jul 31, 2024 at 11:41:39AM +0200, Michal Koutný wrote:
...
> I think the commit message is missing something like this:
> 
> | 'debug' controller wasn't used to provide this information because
> | the controller is not recommended in productions kernels, also many of
> | them won't enable CONFIG_CGROUP_DEBUG by default.
> | 
> | Similar information could be retrieved with debuggers like drgn but
> | that's also not always available (e.g. lockdown) and the additional
> | cost of runtime tracking here is deemed marginal.
> 
> or a 'Link:' to the discussion ;-)

I updated the commit message to include the paras and Link to this thread.

Thanks.

-- 
tejun

