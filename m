Return-Path: <cgroups+bounces-7363-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B75AA7C337
	for <lists+cgroups@lfdr.de>; Fri,  4 Apr 2025 20:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E454E17D03B
	for <lists+cgroups@lfdr.de>; Fri,  4 Apr 2025 18:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0875C211282;
	Fri,  4 Apr 2025 18:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KHnCteTS"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6524E1F0E5C
	for <cgroups@vger.kernel.org>; Fri,  4 Apr 2025 18:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743791186; cv=none; b=ahEkwwMDWDjU3HMOm3E6frXXlzhpm7RV7yS9gSgkiqexwL7AAw9VFlJ3MtRxoa6vOvDxBO9+hGwbOPHEIwwvZHmMp4mHVdvNQu2k1TastEGURulEW6A+clXNkyKOQHOBNoJR0dSBayEMi9OZ+ui9sD6GXi3YZ5MIuUnsiqSA7FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743791186; c=relaxed/simple;
	bh=ZOTccLSgfI9cTOLRpsnzj9bwhsvfPOgW3jKDNeC0EZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CnqpiyrND9hvyNDTGiSoZNftM7DDsa2reMXZJaA2TZQxv8iHU32IDAi2HrOLtqhr+pLAIHRXpTjKyK64n5dYd+yIyj1tHtCZDcTITc6QPECoVwzonBch+RWMTM1rHtnUtzvcvWdGU5IWeGmgDjHoRmlFURmuhu55fmQ1z8NrdPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KHnCteTS; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-39c30d9085aso1381751f8f.1
        for <cgroups@vger.kernel.org>; Fri, 04 Apr 2025 11:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1743791183; x=1744395983; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TLhJnFT3Gwgfc4DYQiW9AZKUF72F44NtVJtW3JeRxAo=;
        b=KHnCteTSyAw1pbj3+oxle6j5KlpYwwHRbQ0kr4eNBN/n8jasO9nCtGCQLG1VeViHr/
         ELJGHfW7G+bZY+8nonSO9a1hQZVZuesptbz09xQnBYUSfmGRSBEySoKD1IHWxV8slmLQ
         iU0Ow83iZFBq/TmVWZEUvrgMVxAJ3k7oZYNOKVDwORAtjhN4/eMET3PWbL/NSf5MPc/B
         rAb6p7j6YrarUERYXlbnffT7TfSQb0As4FJDWW98+cdoxTPEFNUPENWRviM/eLKR0Pja
         YsLLuVgGi/d2/Wl8NfefrK0EHwQlQ0f9mtmCfrNZJerdtYbFTOISpR/lNm2NvBwsiCmg
         yxXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743791183; x=1744395983;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TLhJnFT3Gwgfc4DYQiW9AZKUF72F44NtVJtW3JeRxAo=;
        b=uunGwAF+86BZDWlUfoU088YTU9AWVF3gqhgenCzgcR81y5G3Y2Ra/7Bf0+7ph8kGM9
         B058rLE1+kGN7pYxcb4/mnOTQkcLjmvsJwzoZX9265d4yZs4MHqcphXHc+X3NsVAxcFy
         9scDbJJKAXIrUjUUJJ+D6ZCFgQZDRzgfwMi9j5SyM95GLG3v0gV2y3PRM23N+ZmfhMjt
         rX6Vz0C37OisAeJODOYAYQyiNZLeuIl8hR1x2PWG/DRepe6PakBb0rAN2b2iVHt9jLbK
         pmqa0j73hp4TXilKl8i3rAlymhoAwA5kF+EdAIXQfiqttjAW6z9FSY3hPWaME5C/syMS
         hzmg==
X-Forwarded-Encrypted: i=1; AJvYcCUcJPxukKen6RUq9C7VcrrtZ/gyv92JRVWW3pKFeoKWIop0KHcU1KtIq0JXdSPNyel8B31dI+0O@vger.kernel.org
X-Gm-Message-State: AOJu0YwTTK5+P4iCmI3vLhPJiDGzoag2iy3C7BbmL29gk8/ozk7+FbHx
	GgTR3zbCLs2npRavwXKKmN6tSKdEz4oVta5EQdekRH3Zzx3JuRTI9zFEXL9p3DE=
X-Gm-Gg: ASbGncuA/GRO/osNDLMvDhC1WjCdu1KxmCqH5jshlYd4+LNwNkI2mUDifskWYrO86n3
	QqhVqiGySO6ao9X1YxYY4Q4bR/ClZZuXUfJcplcZcqhn9Fc0HQCxhAmNE7/Dd/y1ITUjU6D8xp9
	afawZzQRo2iHbKeyyFEAuM4Nv/Gp6g+gzV+nk+G1wnh8cwEVpm7BzLPFg3ABoK7sc0PQxMnhJYd
	wdXImXAmjuTYEvlZeZruk0WAcawxodq7VZZugV3WqIETWqPM7xC2WGeo7cWzDFQhYxSChdosuat
	t3hLMZk1OpPA1slaS3S65WRv4B64uCIRSMplRzlsz9wgY2g=
X-Google-Smtp-Source: AGHT+IFVVzcvCxUkq7QqYrnEsRDzq8Ic4YqHD2DrlGgpG3HTOI3DOpixIDGv0syuaug71lzZJsL3oA==
X-Received: by 2002:a05:6000:2406:b0:38f:3a89:fdb5 with SMTP id ffacd0b85a97d-39cb3575d97mr3948931f8f.11.1743791182544;
        Fri, 04 Apr 2025 11:26:22 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c3020d975sm5041239f8f.75.2025.04.04.11.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 11:26:22 -0700 (PDT)
Date: Fri, 4 Apr 2025 20:26:20 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Waiman Long <longman@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Tejun Heo <tj@kernel.org>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 1/2] memcg: Don't generate low/min events if either
 low/min or elow/emin is 0
Message-ID: <aopkqb4bd6sag5mgvnvmoojlsz47lxrgxav7lsywkzeqtb5pco@ptxoqnloplzi>
References: <20250404012435.656045-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3ezm3guyzo3fa3j5"
Content-Disposition: inline
In-Reply-To: <20250404012435.656045-1-longman@redhat.com>


--3ezm3guyzo3fa3j5
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 1/2] memcg: Don't generate low/min events if either
 low/min or elow/emin is 0
MIME-Version: 1.0

Hello Waiman.

On Thu, Apr 03, 2025 at 09:24:34PM -0400, Waiman Long <longman@redhat.com> =
wrote:
> 1) memory.low is set to 0, but low events can still be triggered and
>    so the cgroup may have a non-zero low event count. I doubt users are
>    looking for that as they didn't set memory.low at all.

I agree with this reasoning, been there [1] but fix ain't easy (also
consensus of whether such an event should count or not and whether
reclaim should happen or not). (See also [2] where I had tried other
approaches that _didn't_ work.)

> 2) memory.low is set to a non-zero value but the cgroup has no task in
>    it so that it has an effective low value of 0.=20

There maybe page cache remaining in the cgroup even with not present
task inside it.

>    Again it may have a non-zero low event count if memory reclaim
>    happens. This is probably not a result expected by the users and it
>    is really doubtful that users will check an empty cgroup with no
>    task in it and expecting some non-zero event counts.

Well, if memory.current > 0, some reclaim events can be justified and
thus expected (e.g. by me).

> The simple and naive fix of changing the operator to ">", however,
> changes the memory reclaim behavior which can lead to other failures
> as low events are needed to facilitate memory reclaim.  So we can't do
> that without some relatively riskier changes in memory reclaim.
>=20
> Another simpler alternative is to avoid reporting below_low failure
> if either memory.low or its effective equivalent is 0 which is done
> by this patch specifically for the two failed use cases above.

Admittedly, I haven't seen any complaints from real world about these
events except for this test (which was ported from selftests to LTP
too).

> With this patch applied, the test_memcg_low sub-test finishes
> successfully without failure in most cases.

I'd say the simplest solution to make the test pass without figuring out
what semantics of low events should be correct is not to check the
memory.events:low at all with memory_recursiveprot (this is what was
done in the cloned LTP test).

Michal

[1] https://lore.kernel.org/all/20220322182248.29121-1-mkoutny@suse.com/
[2] https://bugzilla.suse.com/show_bug.cgi?id=3D1196298

--3ezm3guyzo3fa3j5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ/AkSQAKCRAt3Wney77B
SXLwAQCLHjkGHqdonWWfAZmkRMLnnd/9GLDwQHs1pDPkdB+LygEAv1ILh4buquz3
RL8ZpTYF0zHvtsUdp9Ow556iY7pSSw8=
=fCfQ
-----END PGP SIGNATURE-----

--3ezm3guyzo3fa3j5--

