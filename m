Return-Path: <cgroups+bounces-7595-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 219BDA8B601
	for <lists+cgroups@lfdr.de>; Wed, 16 Apr 2025 11:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B16518891CF
	for <lists+cgroups@lfdr.de>; Wed, 16 Apr 2025 09:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B36A23536C;
	Wed, 16 Apr 2025 09:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TpFvVLNb"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7552213B7A3
	for <cgroups@vger.kernel.org>; Wed, 16 Apr 2025 09:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744797067; cv=none; b=cMNQNmmwS4O/e97iicwJItMAK8o81PsvSMYsAf+jgJkn4T+JnbCVTnzuK7ioSiVnQ4BlcygHhPHRCg4ZBF0YdNTT0FQ69hBUNttd3l7XiJh8pMKqQZYB8aTRT9CguuuwWj0Whwn2dZnAHlijUOsecEB783hm7VxilrMoI4tq3qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744797067; c=relaxed/simple;
	bh=3pMApbq5ztRYsS7cQ1NuhLQedG7v93kqCIhd8VmUafQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NO67m3AXRhBSUfsveGL7kDWmULhRlnsq4A7QzdnLUErb+OJx5uadU4hlkEiHZazqdfJ8fDLzlNf5qCELmqnDKpW/ZkHWOnm1TsnlljY4zbe0WAH/dJB6vo4vJtc6SYcOHPsHNk2OoqvrM1fnX4HJiUgPhe58lI2TfvAruTAFtB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TpFvVLNb; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43edecbfb46so44600565e9.0
        for <cgroups@vger.kernel.org>; Wed, 16 Apr 2025 02:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1744797061; x=1745401861; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3pMApbq5ztRYsS7cQ1NuhLQedG7v93kqCIhd8VmUafQ=;
        b=TpFvVLNbHpXuAMXRvz25jMXbUdm/j1lPFElumduuOw655J6bvgIYUaIsctFSSuDm/W
         MW5jrT+V/FYtlksFw6w0280+IPYwWfu2tzIdiEotKg/gASeUXj9wju40VQurHCIVhya8
         7R/qO03GHuuC7GkR1BIu8Ty0wcu2UXmOBR9HNyQaQgF9ISi3D88p6B7urhI1m3w8WeVO
         Y6JhOZ3xzTQsYOJdpL1hEUrlXbjRwaRDGhETZ4EpGmDbWLtUAN4QaiJDhwDjwrhzwX7q
         XhMZ8TDjFLyFQVCwOfcS2msNCYsvTt32RIQQOlDE/X2F6+RFSyoxDXFws2ImzNgTjhuu
         tSsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744797061; x=1745401861;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3pMApbq5ztRYsS7cQ1NuhLQedG7v93kqCIhd8VmUafQ=;
        b=YsR1bwRjhtayvDw1qxluWu5GQWfVmVjXStDQumD+4e45YU7pvPG/lTTBIBDoEr5bo5
         UboXKdXZVgmxipfwrLV14vTItO02rTgKqKdWdmS1Ns1Z0Js+smlQLaPa7VrxUS4YQJmf
         EeiHeAWgCi0HkZZf1Ntxuyo/PXpBVfAkdzzgGIK88afNUbqsW+J3I5CoUBGNyfQv2YdT
         MCGjtoeVB3m84uS24aMxpbmnc2RhjmmkP3E1WjQe2vLMQ11/CW4jJrSVMTMkvLpyjxOO
         rVl/15S9x+PvYQ5TWf+Oo26LrQg+QeIoUOBqtIWfOh01TA+NUIl3Mi7iH46NeeUkx1Rd
         y6Eg==
X-Forwarded-Encrypted: i=1; AJvYcCU+keuUkvLpg9shVHvvWDRU24vq+9rRCCxZQyET1OQjCCp30daMQ3+4LcqCVXhEQ1FSG8ctemF4@vger.kernel.org
X-Gm-Message-State: AOJu0YwSlQBfpj+wDpS8VvvApeMl7PjoijeW4NFGZ7bW85+HQn9oFOz0
	dJRfewA9xYwpwI5Cq1wAPZE3iR6Yyf4Tz/qGrpW4PY63O+7p3Ei+LndSM2MhWOU=
X-Gm-Gg: ASbGncvBhhCUZK2gtd1Ovvk3z5AqgKr5Ws24/9Cz5ZJZ9g74+kcFoLz0jsGjrd45Ln8
	jIbTfc/MBST6dXo1BoIhd4gZnN4ftqy5MOq2sCUXFpgruuQsfP1Vfdlx4MU8bS1/ZRl4sLwEwJU
	q21BLKNwLQ9T96bQ32UcjLjS1X+so5Ec4/15BtYztwbpmnp6wB0MmqQfngyVEcJWPkbVEsgAI7E
	P2NObtH/f2j0XKNCVMTE05mWqqpizHBknQyAljcmsc5t5s8QKv8Ghm3xfnufK8QBMkUAvO1BoRK
	F0M0wWQgKNVt0xDW0RRKhmz17hBq3mpVizY9IIc4LnOZB8CbYAxHXw==
X-Google-Smtp-Source: AGHT+IHJF/p17Dufq7LhZBJTAZkShM8WLci6d/4iSrWFNucbDiEWU9bcds7Vn1ogvPpZZ7U89v3B/g==
X-Received: by 2002:a05:600c:a0e:b0:43d:d06:3798 with SMTP id 5b1f17b1804b1-4405d6adc5emr10705965e9.20.1744797061518;
        Wed, 16 Apr 2025 02:51:01 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4405b4f3ed7sm15893355e9.24.2025.04.16.02.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 02:51:01 -0700 (PDT)
Date: Wed, 16 Apr 2025 11:50:59 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Tejun Heo <tj@kernel.org>
Cc: JP Kobryn <inwardvessel@gmail.com>, shakeel.butt@linux.dev, 
	yosryahmed@google.com, hannes@cmpxchg.org, akpm@linux-foundation.org, 
	linux-mm@kvack.org, cgroups@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v4 5/5] cgroup: use subsystem-specific rstat locks to
 avoid contention
Message-ID: <gmhy3l3dlywtytmnwl3yegwf46hshshavknurjtzyruvfysp5x@4y4axheathhx>
References: <20250404011050.121777-1-inwardvessel@gmail.com>
 <20250404011050.121777-6-inwardvessel@gmail.com>
 <3ngzq64vgka2ukk2mscgclu6pcr6blwt3cwwmdptpdb7l7stgv@vhpyjbzbh63h>
 <Z_6z2-qqLI7dbl8h@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="e3omb6cioty2fwbc"
Content-Disposition: inline
In-Reply-To: <Z_6z2-qqLI7dbl8h@slm.duckdns.org>


--e3omb6cioty2fwbc
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v4 5/5] cgroup: use subsystem-specific rstat locks to
 avoid contention
MIME-Version: 1.0

On Tue, Apr 15, 2025 at 09:30:35AM -1000, Tejun Heo <tj@kernel.org> wrote:
> I don't know whether this is a controversial opinion but I personally would
> prefer to not have __acquires/__releases() notations at all.

Thanks for pointing it out.

> They add unverifiable clutter

IIUC, `make C=1` should verify them but they're admittedly in more sorry
state than selftests.

> and don't really add anything valuable on top of lockdep.

I also find lockdep macros better at documenting (cf `__releases(lock)
__acquires(lock)` annotations) and more functional (part of running
other tests with lockdep).

So I'd say cleanup with review of lockdep annotations is not a bad
(separate) idea.

Michal

--e3omb6cioty2fwbc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ/99gQAKCRAt3Wney77B
SSBhAQCs10FlWiypOfGmgQpV+PJhecrxt3yL9WWOZDAaD9OWZAEA6UgNdBlY55Es
/MXqH6C2ak3lSh51C3Ta9g/yOILvlgA=
=eOoB
-----END PGP SIGNATURE-----

--e3omb6cioty2fwbc--

