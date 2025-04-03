Return-Path: <cgroups+bounces-7328-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F882A7A3DC
	for <lists+cgroups@lfdr.de>; Thu,  3 Apr 2025 15:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 266BD1897159
	for <lists+cgroups@lfdr.de>; Thu,  3 Apr 2025 13:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55F62528E7;
	Thu,  3 Apr 2025 13:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MS2BBpK4"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6975D2512E5
	for <cgroups@vger.kernel.org>; Thu,  3 Apr 2025 13:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743687230; cv=none; b=YsGwJRF63La3GF1TOAfjQHj9WAdhPbyV1SbJQgS6hh2JQYayi8fofLkaYGVYebanRfJCR6bJZSZBIjtfXqsacF0ec2IGjWW0580CBxsTDlHIcWoFQRhPzo+EsTglMZENaZHpMagzfYywKbCpBhgpKrDsCjpHR99D68sVXkzdpEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743687230; c=relaxed/simple;
	bh=lc2kPBAUmFssEFHlFoZTIb5ZMulQItOIPpogF+GOBDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fjavdH69w/B5evtPs/6lW3ifO/9sUXRGj/R1hzhpvi1YouCyhICyXUzTRthZ/0liioNN1DfhgCFIexfu/UcqwBqzs2Jjbbo80LIGuSRu07YjkxYc0hCGo2nSimLs+bK+cJ/YifKRo72x06oOW9g/KnO+OKFUyh5oXb7eYVwbXXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MS2BBpK4; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-39bf44be22fso662906f8f.0
        for <cgroups@vger.kernel.org>; Thu, 03 Apr 2025 06:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1743687227; x=1744292027; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lc2kPBAUmFssEFHlFoZTIb5ZMulQItOIPpogF+GOBDc=;
        b=MS2BBpK4jF96H1cgO9M1r1+ao2T5RFgHwAJnpbz1/0lPyIUTnimEJW13nV4ugNUUIP
         lqcxa+eNdau4Ox+kneB6LMt6+1zpPMDjCTz39pQMflNmtKq0KCy4Y0LpgfPZT8ZH6DqY
         +mHc+XZIPyTMrc51qN6CcvIIyO9q5yCRnMoMMwYGZwwPZNx+aVwxzv8EhqJrXhqEKsYL
         HmKnOCz7tNHdOrd1W9RMDNlaX4XniRyJth8V+k2zJ9MWfGLnTkz8VdfPjJoY3H+LAAOx
         icVm5/Wy/Qt6xX28LmwZscnDFb+WM23EOwDFkvt60AxXY2YlDtTW5FH1zc8TeBZvHorq
         NoxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743687227; x=1744292027;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lc2kPBAUmFssEFHlFoZTIb5ZMulQItOIPpogF+GOBDc=;
        b=GjJBbDpZurJ5aY26TxfeinaAWmUpBxy4s77gtnf6Uj/K6ns6vukFZtL75Z8tTbt8RU
         l6lzzbcaooQ6BCU5DerSZAnTpqa0Xlwxq8qarpXrYincpxdufD7TafcerD063NKlPoga
         PQUCdr5Zjaj+MOrhqI3pYgp3fXhdst703vRCUYM41Tp3djKc2ajPCC/MEX8OKkhfjzaQ
         hWZo1ZAkzR39zjG26fztUTfq8PePBkAvAehqg1KRUU/kd2ZdvGZj3ZBfcs8xDuMMtmnV
         wrfTpiOSuI3kMzWtKarTk2NK5pkGx+lVQ0ZBReTSGXhKM6KKX73hLN693xPcSMrFtDlF
         970g==
X-Forwarded-Encrypted: i=1; AJvYcCWogYR2v90rF2DWYH1ZcLBaH5M21G53DJtBhTOw0OJzAOIQBMNm27/kIsNQg4Oq+RlLS5Qf1NzT@vger.kernel.org
X-Gm-Message-State: AOJu0YwLAjDCp/0S50OZoT3T4XN5g+uQqPmySHzcW0DWPiLnwuSfKXTW
	czK6O0rfUXZgilHSyHU9++45c1u0dtSmY1K4itlOJzXVPiqYZZwP1jlmKg5Jqjg=
X-Gm-Gg: ASbGncvxjVhSytHIm3e845374fwfxEU3vzhgwx0gVMO5jY/ZSY3FnNQ/ldCdp7YLznH
	/Ny4ZSEM0vdINiZUD0LNCfscgTQY0fCMvv+whNmCX1doNacUlYQtK4gu4S/wyNa98QrwVW91tgp
	IPVydOmejz2VUjHvEqoEe9Vi4iFKJTy4TGsX7S6l5zJq+iGHP5UrkcCVahAXG97yX4/9mt+GkD+
	C5UFyxE+q5UveYgdp4tgDtWhpJr4wT1BYdnQarcxq0tem5c2/YO7aifIYUuB0KTpwNHZKuNS5Pi
	QZxJBgjRjCmLumT+eXzdKqaKln5wa3BcCyXL7HF5OhAHwcw=
X-Google-Smtp-Source: AGHT+IGPQ6nwxEwKgFP3ExKTxhy07cHsFvtpQAvnmiKOVMha0c8lkk/HwjAtM+b4ugng/LTLNl3c5A==
X-Received: by 2002:a5d:64e8:0:b0:39c:d05:37d3 with SMTP id ffacd0b85a97d-39c29769556mr6233270f8f.34.1743687226677;
        Thu, 03 Apr 2025 06:33:46 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c30226959sm1768861f8f.82.2025.04.03.06.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 06:33:46 -0700 (PDT)
Date: Thu, 3 Apr 2025 15:33:44 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Waiman Long <longman@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 05/10] cgroup/cpuset: Don't allow creation of local
 partition over a remote one
Message-ID: <c5akoqcuatispflklzykfwjn65zk7y22pq6q6ejseo35dw5nh2@yvm7pbhh5bi4>
References: <20250330215248.3620801-1-longman@redhat.com>
 <20250330215248.3620801-6-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pjejnus3mirkel3g"
Content-Disposition: inline
In-Reply-To: <20250330215248.3620801-6-longman@redhat.com>


--pjejnus3mirkel3g
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH 05/10] cgroup/cpuset: Don't allow creation of local
 partition over a remote one
MIME-Version: 1.0

On Sun, Mar 30, 2025 at 05:52:43PM -0400, Waiman Long <longman@redhat.com> wrote:
> Currently, we don't allow the creation of a remote partition underneath
> another local or remote partition. However, it is currently possible to
> create a new local partition with an existing remote partition underneath
> it if top_cpuset is the parent. However, the current cpuset code does
> not set the effective exclusive CPUs correctly to account for those
> that are taken by the remote partition.

That sounds like
Fixes: 181c8e091aae1 ("cgroup/cpuset: Introduce remote partition")

(but it's merge, so next time :-)

Michal

--pjejnus3mirkel3g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ+6ONgAKCRAt3Wney77B
SU6VAP4ynbl5wnoim3pRoEDFYW9TwsFFO1oqvsJdRQbrLPKb/QEAsizzl8zjyzkV
3IT57x5+x3Tpe2KO9CLsl/Pj29WW2Ac=
=P059
-----END PGP SIGNATURE-----

--pjejnus3mirkel3g--

