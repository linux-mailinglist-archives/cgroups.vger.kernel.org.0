Return-Path: <cgroups+bounces-12905-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6202CF1D80
	for <lists+cgroups@lfdr.de>; Mon, 05 Jan 2026 06:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6DA533017EFF
	for <lists+cgroups@lfdr.de>; Mon,  5 Jan 2026 05:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162BE324B33;
	Mon,  5 Jan 2026 05:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DPaiStXi"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A980322B84
	for <cgroups@vger.kernel.org>; Mon,  5 Jan 2026 05:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767589710; cv=none; b=V7mdJRU0DJEoT4ACSKu1rXTRle3cw091ytJu01PPXN3FfYXr3MRRCSk+N6SvzwrvTCF1BGAAJfShXErv8DHbZHsvehOt1Y6Ggv56Gd4tMHS/0FgU7mSOfxqVyBKIqqA0JYCM9enDFuCcljkTDGR4HhK+L1gvdcKDuzPs5mcnK0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767589710; c=relaxed/simple;
	bh=+04wm1UCl9KIPAir4UBfGkCW95fMzLVX25tujB/CHaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=md7Al505xKQbnCxxzcYWnJHn+5a6c5PUA/6/RjV3TRQUL3iinuz0skvB25CjkIdc/mUoPOG1QTfruvAqDkIfAkvNFk1dXXuoahKmbLdurTxw3v3rt9ofT/zdmj+5zx9vzHog98GHXWHXLrAyQsHDep4php8Q1S9Vlmkp7LX4XRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DPaiStXi; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-29f02651fccso182065ad.0
        for <cgroups@vger.kernel.org>; Sun, 04 Jan 2026 21:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767589709; x=1768194509; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cd/jk1OYxxJI0FgFMQ/4AyHrYlkj9I7IC7MmkMckJUw=;
        b=DPaiStXiDdhK0IAmGdPW26fTWKcqh4zHghzWxl9tUdkgj8/rq9wch0djy68zV0cLUm
         26BNMTGsQSzm+CzSdF3wpTH1NPq5aCsblbiSyv4S4G00LUNNGclo7nDVutFoXy6otyFp
         N4OJsw6SXiwoWJrimyIEW/dvEv133VFy7yR2QvLe+RBMPh2/5hSTa5Iy1vtBj0SlKWs5
         fLjtITG3MD/PX+CT5M4vzQG3aYPO5Y+o7e9eY6G4Vrb4yRn8Bd4AYQvvnwWogGbqDjeg
         ZVVGFi9OLolQuEjYEKAWH0W0ifrBvq00cz5KYgnSdHjmqaWLoGaY9QPIlXAiW76pZQXR
         fIgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767589709; x=1768194509;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cd/jk1OYxxJI0FgFMQ/4AyHrYlkj9I7IC7MmkMckJUw=;
        b=EqdAw0UJM0wsMlgTAYcrPita2hAVWYKv+aAbrV3U7W5XH4kR3ap2X6nN1giEnyeZo2
         P8cgHh13WbIkUiXUB9QlixsV0HY2Wi+j1uyrLh+Wl4I5wlH9JxOS3WVoR+btAaJr56EI
         PRkErTZYLH4WOnApxSN6VKwfaISofFq41/+OZtUj0uabFu9hslAijd7Yt4hge1wrbaqm
         9QC0GPShShPkzZkaLka/EYH8Cfnvh++onX5p38QsVgBInbdFEqHP91NmmlIxru+iG1Ac
         XksS6cu89HQ4u6u+KhHS8zDNDetJyChX7Oc5d2Y+spYiu143DLSgAAxvrkcVYIVO/OaT
         yuVA==
X-Forwarded-Encrypted: i=1; AJvYcCXGAWDMTa8/jj1qXlgxbNsYKQRrJya3awkr00+T9YCBtA+BnY1tnF/DCJSfEQ+9eFIYeVthT9x5@vger.kernel.org
X-Gm-Message-State: AOJu0YzaAweflIgX4l9t/HitYo4TqtXkPZa7ek5O4GbntlmTkzX5AO0I
	gBZXLBR5zoylU7p7GSnmhBYWnU2iR/ub0dxmMrsfOuCI3KybdINa+8IQYN9NflAgnQ==
X-Gm-Gg: AY/fxX5ltx0AA8wJ+Vvh54fSb7eyYpXAubrf7KubdQZ3NXX2WNetLcbPFpj9ARNtka4
	Ib51J0jQlw+AdjW2YsII6ma4o6sJ5rAhSg+C4tlM9fLSfOGbsKRswm8UUGm2/p5nP9yYVNO0FsE
	mfV6RiSRYI9oa2TPJsaVr7LupRhu5CkNtsSR5GtxfAu6H0qg0HR/EVtfeYZiVuBZSgBg3RC3/rw
	CkwcqQ1s+XCiOl/WDQmpW7+SZcUUFPhbUvZCjYeG39kcWTb3mFWIcxVWsIJm2VBu7Dm0yqleAjl
	SOjdWXZf727k/5Xp8HDUdzBnRSCdU+8xgSaTLwaTiUi3d0538ZVOFeiC2u9RxBp5mDzBtDnW/f9
	8i1V7NnOi6yguh5GLB7vz54JEXDRellR3W07keeUlYzJcz52vV1bAHdWv9Q1Nv9Ej2PAcBzyxPn
	pUAmHuehN2QctzP23iEIYQw3EKux3CB/+5OlfxWevgEAkZXKLr/3C2
X-Google-Smtp-Source: AGHT+IGk8Jm8wNCmyi1j3iw6iak7/1We7ESwQmtL7zKxxPgAfcDGUZnYJOZFjtq1xd+E+EX1n5ZlNw==
X-Received: by 2002:a17:902:d588:b0:29e:27f4:bac0 with SMTP id d9443c01a7336-2a3c1c161d4mr2381045ad.16.1767589708401;
        Sun, 04 Jan 2026 21:08:28 -0800 (PST)
Received: from google.com (248.132.125.34.bc.googleusercontent.com. [34.125.132.248])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f45bf6f1dsm3187814a91.2.2026.01.04.21.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 21:08:27 -0800 (PST)
Date: Mon, 5 Jan 2026 05:08:22 +0000
From: Bing Jiao <bingjiao@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, gourry@gourry.net,
	longman@redhat.com, hannes@cmpxchg.org, mhocko@kernel.org,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, tj@kernel.org, mkoutny@suse.com,
	david@kernel.org, zhengqi.arch@bytedance.com,
	lorenzo.stoakes@oracle.com, axelrasmussen@google.com,
	chenridong@huaweicloud.com, yuanchu@google.com, weixugc@google.com,
	cgroups@vger.kernel.org, Akinobu Mita <akinobu.mita@gmail.com>
Subject: Re: [PATCH v4] mm/vmscan: fix demotion targets checks in
 reclaim/demotion
Message-ID: <aVtHRi-D3iSb3ZkQ@google.com>
References: <20251223212032.665731-1-bingjiao@google.com>
 <20260104085439.4076810-1-bingjiao@google.com>
 <20260104102745.cfd4f6bd661e8e817afcdba8@linux-foundation.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260104102745.cfd4f6bd661e8e817afcdba8@linux-foundation.org>

On Sun, Jan 04, 2026 at 10:27:45AM -0800, Andrew Morton wrote:
> We'll want to fix these things in 6.16.X and later, but you've prepared
> this patch against "mm/vmscan: don't demote if there is not enough free
> memory in the lower memory tier", which is presently under test/review
> in mm.git's mm-unstable branch.
>
> This seems to be incorrect ordering - this fix should go ahead of
> Akinobu Mita's series "mm: fix oom-killer not being invoked when
> demotion is enabled v2".
>
> So can you please redo this patch against current mainline?  And please
> also review the "mm: fix oom-killer not being invoked when demotion is
> enabled" series to ensure that things will work together nicely when
> that time comes.

Hi Andrew,

Thank you for the detailed explanation. Patch v4 has been sent.

V4 is patched against the mainline. Tested on both the mainline and
mm-everything (after Akinobu Mita's series "mm: fix oom-killer not
being invoked when demotion is enabled v2"), and passed.

Best,
Bing

