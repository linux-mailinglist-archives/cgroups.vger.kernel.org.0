Return-Path: <cgroups+bounces-7946-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB0EAA453A
	for <lists+cgroups@lfdr.de>; Wed, 30 Apr 2025 10:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06ADC4C4B23
	for <lists+cgroups@lfdr.de>; Wed, 30 Apr 2025 08:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECECB21421A;
	Wed, 30 Apr 2025 08:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="A8FVBVVc"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF562FB2
	for <cgroups@vger.kernel.org>; Wed, 30 Apr 2025 08:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746001530; cv=none; b=Es7H5Pn6rm9UtP3ly62TO+j7FQQXSCdAbTf0M0/n3q64T4ioPCKDY5ZqrdntKPPXgAOvkRBgg8Zl991w1G5S5ucz89vcnv+D5awdtl4abg2Yb9NkjpLFHafFSM2kfO6gzsgIM4xx9mnF5NLX1JAue+oUkcEUxjFh906D6bM3Hs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746001530; c=relaxed/simple;
	bh=y04tEkznaf/r7EDL7uK8dny8auZ/0Be5Iq+Tj6tHOVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wh7KK4IEj3cVQv+DZVOqPw7udqkzDrCguGAn6hKiIY8dugJheJTym/nsnuCJpM75z6FhUmBEJouQ0fnX3aYdHXCdhoTDIbXJ2kfpqgXY/SVii8x4rfE4d7cvbVOBPjtKpzTNbsNxKTD3llp1zvduDIrOuTLxSK5Z1dLHiQI+30c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=A8FVBVVc; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-acb415dd8faso973996666b.2
        for <cgroups@vger.kernel.org>; Wed, 30 Apr 2025 01:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1746001527; x=1746606327; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hapNsvwk/Rnf0mgmDnPu3qGgijaYgiJF1WxcjPg9iO4=;
        b=A8FVBVVcYt+bDLRKEd1NUbPKaeCHq2iCxy987HgvgDerS6ubNTJRLjGiVcdCEVz4vY
         qvdeuSm52VzQgBymFss365na7qgDqJn5qhZTQn//O7rRX3vIJM30wzVT0zLK9zXN2yYC
         Zs68/mhVk/CblPp84GfMSE//2s9E6MtPVxvOqlqdkKgynine1mY8i7uxSLgwrdcj9cpi
         oMboL7hd3iscbvPo/ST1Tmi8QbqpD8t+5tquJwhyHv4pu+cITiBsvrdLtJ2UarJR5llv
         T2wNsUrYP5XPdsE2pMIHb/VkBNdSUVoIhY/8j++WFIt34ot3CmlqYMH9iiSmRbPHcAaT
         lQ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746001527; x=1746606327;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hapNsvwk/Rnf0mgmDnPu3qGgijaYgiJF1WxcjPg9iO4=;
        b=aw0Xha1NwjwmQnsybBOUAKvavAPjuJdgI36hp5KWsfJbz7bjVsVBy/sTktGs8ka5PB
         Z8EA0JH3sZyhh64gEbRZQg90l4ea6JnLkXtPXmINfEm8vXAuk4UhXzKZiOPFKO4nrBcb
         JqEEFZnip1AvIdUONLw+5RVUCLZ2tCk0R8iQmOmaRmz0606sxvsdzswnChKSrO7N4U8I
         4W3tU8ZxVipAI1OgbrVkIOIGcKSQo8rlWQc8hbu7DmsHnSP3RDUwEzopylZk3xtyEZA1
         JHxJjD5SYftdEvk5qe0pM4YNMonDswxQp5wx/n7jyT0vElCHDNCVJb4aqvyhLeGW47ZF
         pxww==
X-Forwarded-Encrypted: i=1; AJvYcCVKpH2QUB/GZ5ejlv+iu6ERtMjxwL56PV85Em6qnq0XB+QgCbKMRBPWTXDONJ0k+wFyJ/jy61Si@vger.kernel.org
X-Gm-Message-State: AOJu0YxrHQSwqZPWRKnTlKcR6GnOo5qQjTaWLq892AefGBcssy871+qy
	r1ikzjgQxsDHYpvJ1jW01nMPLE1zzkDtNK1J0iiZ5HCqc2Ak6DfT3reIOz5CpHk=
X-Gm-Gg: ASbGncva6c9hvIIA6gWWwtlk2iHRHniuKXHVHVymVOhnAqpaPG3tTr6vwqLCWypZ8Ij
	uAnqNkKVN7tyd3iMFRVbeMk4VBTOrYb4Q+iFCCe6HXF8G6TUflZ+IEIu0iL+Vbs0ywxyWsLpPY4
	LnT9LHQ0EAXsUdEdH+w2RLWZ2oDig5rfEB2HQ152jwCAU/2S21AgfsZSnccNUZYh7UomuSbo0hs
	7GFiTDdASzUAbQ5iR3tRRcYH02iC2Q24yksg/HP8vKgBWYsb3r/TLU+ExIYfCPbXVGFNF39IrQb
	AB0VnnToTFQd1Lvb26f1RdrU9Gpfb4k=
X-Google-Smtp-Source: AGHT+IGtcUQ2cQc6JXumuzWFyrkuxQZag6xvpMj3QJ+YKaYVGKukb9EGVqZXQKT5u85cjhqul4Yy8A==
X-Received: by 2002:a17:907:3d46:b0:ace:9ded:3292 with SMTP id a640c23a62f3a-acedc629414mr282686466b.29.1746001526755;
        Wed, 30 Apr 2025 01:25:26 -0700 (PDT)
Received: from localhost ([193.86.92.181])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-aced892712csm111462166b.161.2025.04.30.01.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 01:25:26 -0700 (PDT)
Date: Wed, 30 Apr 2025 10:25:26 +0200
From: Michal Hocko <mhocko@suse.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, cgroups@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [bug report] memcg: multi-memcg percpu charge cache - fix 2
Message-ID: <aBHeduANJBgQlyeD@tiehlicka>
References: <aBHazntT1ypcMPfD@stanley.mountain>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBHazntT1ypcMPfD@stanley.mountain>

On Wed 30-04-25 11:09:50, Dan Carpenter wrote:
> Hello Shakeel Butt,
> 
> Commit 1db4ee9862f9 ("memcg: multi-memcg percpu charge cache - fix
> 2") from Apr 25, 2025 (linux-next), leads to the following Smatch
> static checker warning:
> 
> 	mm/memcontrol.c:1959 refill_stock()
> 	error: uninitialized symbol 'stock_pages'.

Thanks for the report. I believe this should be addressed by the follow
up fix from Hugh d542d18f-1caa-6fea-e2c3-3555c87bcf64@google.com

-- 
Michal Hocko
SUSE Labs

