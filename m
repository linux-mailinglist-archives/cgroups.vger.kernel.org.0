Return-Path: <cgroups+bounces-10222-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D1865B826FA
	for <lists+cgroups@lfdr.de>; Thu, 18 Sep 2025 02:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8F6A34E2F08
	for <lists+cgroups@lfdr.de>; Thu, 18 Sep 2025 00:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1AC211499;
	Thu, 18 Sep 2025 00:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KzGvJlF3"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A02A1F12E0
	for <cgroups@vger.kernel.org>; Thu, 18 Sep 2025 00:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758156379; cv=none; b=rCeFrRrlecL13QYD5HBhbJH5qu/sc9O9/GUNnJInTWZZMnqeAIm5fpOQPoDooPDkw9PC6gJWgDpmYSqVkfbPioSVoWxfGyh6KEF/E7L/C0jz3mfPJ8rwhV4fsBcl6EdQessGUOKmdkcJ+EdmiL7O8/EXEB7oe/ZCywebbt2FNX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758156379; c=relaxed/simple;
	bh=UIo7RA/G/xDD02JBTiyBlQlJJd9IfyisvvvnbSKMNJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MHyA67E6b1rMtxLMPplWxk2MLUI40OxdF32GNNT4jn6OSVik0Xj9AJHJoViVB9Ff5tMjINKcDfNRtEONKzhvcBGRneMYGLh1w2Gx3XdpMkngAGxLJhSZfaYrBVfI21EsTn1r1JT3o+h8ZqJ91lOOlxI878Oda/53qJTmaktyiq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KzGvJlF3; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b0787fa12e2so61758266b.2
        for <cgroups@vger.kernel.org>; Wed, 17 Sep 2025 17:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758156375; x=1758761175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ScdSoNWwYp7Lx1FqF0sJinLc5HuMMzMbeEOteqLeKGY=;
        b=KzGvJlF3KPV470aj9p2+WGc+dHQyYumQ/n1JBBocmuZJA49YLeiUqmwy+/yYPZgQZj
         ssXCb7z6YgYiOutrT3AfsrRikN0B83+7ruvziWNhCwsz2ELTIiizmfls7PvsFdkvcJLT
         qpJdXp6xZhBTLS5nekg+F1LDSdhm19EysHMtk07fabj1P6oLuOyCMfvOGen6jT1eBwbP
         6pMnjF6KJT+0XEj91pCTwQujjt7F6ghOtnCnJ+EU2+tXugoJTsFgk+QsjwfhKOKRRjgu
         d9FePQZs61kpvgUTD0qeflLnFiVK5p7eAvAv3yf1sOrJiE6TsrG+zJ2UIlYBCl4PmRtc
         hKkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758156375; x=1758761175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ScdSoNWwYp7Lx1FqF0sJinLc5HuMMzMbeEOteqLeKGY=;
        b=ABmOexPUd53Um51uk3ldbMjTmjUcQigjx3tXDuqH5GMcv/8HvJ/fOcelM8CNu2j8Ch
         fcO13eYBUcYjgiXwdLVIX578UlLkYk+GE2ZoLxTt0yPynpaEy6bZo4AJhhke7O3smp9k
         8C2NFHvY5W2Ba+iZ8YYaV2Y0xP4TBNI14mK/9dliMtJ6LH2o9bwfXhl266jh9CCX0Gy+
         tgfWpVvD4mwpQ0g9X00B37GtX5S9Qfg3sZ+vq5hr2Dk1mj1QRoCMrcyEkQsXi8M1M8FE
         Yuge7pVDawJ5ddjoO2G5EJFYaXtBdNCY3YDho1OpMiD4SbNLKkDbkqLM/xFEs6MJ66gJ
         t19Q==
X-Forwarded-Encrypted: i=1; AJvYcCXQvVsafDI1mTTAHGqTxkfsgHr3P1rnRaJ2RStPeejFHCjVx+e2jmqhfLuNo3uLmRefD2d4rlki@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3IEy5sQ5Bc6ykA4P1xZIBzsu80fIzh4rqoBoD6dLQEXJvGaXe
	rT2JzC58Y/eCENIf028RnNhNQPX+u5XYtHAveJgRC4pxzFvPH5ySGouX
X-Gm-Gg: ASbGnctbFCVLJy5fFDK0hAuvA9Gz25Gk/tk1WdLAm65DkA2Gc3nOZ5kHhmoItkbuDgw
	E8H3WHyNEXB4ELlcmOYT+cwjZmMWdPvS8YLICFmmSpow+ipQSthk0TNCnahvBkRNaiD/YNvBIju
	p299TUQI2zv1AYKzeLIAPO6f0I/ibZjWl74Q9mIymricU6W9hEMDTlOKmCDCusjTUFLlo9rte3R
	DBPc94ppFNTAGDQOTVQgHoVzKcGBiusBozzxQi0mTtBc6eXntw2qNtGisU5lgYOy3LJNrJvJmFU
	WIMRhFqku7nznF9Z/2mmQYrH6w0wIpOOXrKjvOe6U52XPR5bQACmnEo2jnuuNeOjje1QfYxv7+N
	0COTD426jHNAWi0JdbUAbfG4900HyGCWazA7iKQ==
X-Google-Smtp-Source: AGHT+IGtolM3WpmMOfPkC5aQN2+QGXojyD9zctBgGDhejOP10KXv+fVObxP+zNTcUHL0l2vGVmYa+w==
X-Received: by 2002:a17:907:7291:b0:b07:c28f:19c8 with SMTP id a640c23a62f3a-b1bb7d419c3mr514517266b.30.1758156374473;
        Wed, 17 Sep 2025 17:46:14 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b1fd271ead3sm73266366b.101.2025.09.17.17.46.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 17:46:14 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: brauner@kernel.org
Cc: amir73il@gmail.com,
	axboe@kernel.dk,
	cgroups@vger.kernel.org,
	chuck.lever@oracle.com,
	cyphar@cyphar.com,
	daan.j.demeyer@gmail.com,
	edumazet@google.com,
	hannes@cmpxchg.org,
	horms@kernel.org,
	jack@suse.cz,
	jlayton@kernel.org,
	josef@toxicpanda.com,
	kuba@kernel.org,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	me@yhndnzj.com,
	mkoutny@suse.com,
	mzxreary@0pointer.de,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	tj@kernel.org,
	viro@zeniv.linux.org.uk,
	zbyszek@in.waw.pl
Subject: Re: [PATCH 17/32] mnt: support iterator
Date: Thu, 18 Sep 2025 03:46:06 +0300
Message-ID: <20250918004606.1081264-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250910-work-namespace-v1-17-4dd56e7359d8@kernel.org>
References: <20250910-work-namespace-v1-17-4dd56e7359d8@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Move the mount namespace to the generic iterator.
> This allows us to drop a bunch of members from struct mnt_namespace.
>                                                                       t
> Signed-off-by: Christian Brauner <brauner@kernel.org>

There is weird "t" here floating at the right

-- 
Askar Safin

