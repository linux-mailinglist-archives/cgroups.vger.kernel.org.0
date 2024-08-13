Return-Path: <cgroups+bounces-4236-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40838950CC0
	for <lists+cgroups@lfdr.de>; Tue, 13 Aug 2024 21:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D18EBB24B26
	for <lists+cgroups@lfdr.de>; Tue, 13 Aug 2024 19:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7ABD1A3BD5;
	Tue, 13 Aug 2024 19:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CSdhxiQy"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0EC1A3BC4;
	Tue, 13 Aug 2024 19:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723575724; cv=none; b=GyRQMovpgVs+r2Ew674SH8T3rQ4n7d4O5oXMbI5QpMnmnY8CsugNbzSQD5BwIE0MmQXKSibhE3LXYtoqBQMzttwlNS10xC8Spychkv0G+FuS5m2AqKDJiLsvRCP0qYPuN88nplawu6wQYB03yoEc1IZd0XmQ3+F/GmFRS5q2tOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723575724; c=relaxed/simple;
	bh=Zn1CdejGdzH3qrvO4azODSklzSoXsl0lU9zBAeb/I6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rVaXHxtAVXUMK1C+HmpNUfRcoMxfXOfEu9QaufGAO1woRjZSb8aeOayI/bmrct0UpORnqp+t5eMCxXWVM0NS9QzftR0zywWoaVpN7bVyolvZpxG3EE42ei5v5hEclE72yaT/tLB555r1p3K3I6UozIYm6+HcGAYOjxWrD6yEjOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CSdhxiQy; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1fc47abc040so38986155ad.0;
        Tue, 13 Aug 2024 12:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723575722; x=1724180522; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s068iVhOZ+3GA1IKeu19ZmOzE72AR5vLObVpRyMcB40=;
        b=CSdhxiQyxdr7iXMyHs4j/GzDDQywY3fePUJOl49GoIHMLZC+AVyNmzsPRUcHi7JQEP
         Dn1CHY0yn3HluK8g0QSk9N0GhJyTEEOqc678A5GwLTBFsZg/nlT/lsiBZIPqfz9uPmWI
         FN+h53C22Gj+UipsjVOJoJhBNPmhAXA9R07vThSOttpNQxwq7zDiA7LGExPIa0ry9vBz
         vgsN+rAmeQCWNDF1B4QssGIAB/o1eYF+sOWZr+pCQ8Te+Z5WPfzkJ7caRPcikS5hMWOW
         jr2wuJYOMsA+XeoLCx+hRKry8EF5LOSe41/gEsLnwGeyXB9ZXPvZTlw7RxnZtXCuKHyq
         Xptw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723575722; x=1724180522;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s068iVhOZ+3GA1IKeu19ZmOzE72AR5vLObVpRyMcB40=;
        b=rmuR2QAW+Ib20bswjnWzrQNjzxRjQvdUk4TGxZZIuayko1mKDDuNP6YXMivxOAuVff
         VHGeIJyhZnQmF+N2V4UKbC9BF4bL4nCrx/dMC1tqDpgR8ohoRSi6AicXoqXrkzO9571I
         97b3fPqU8N7Dlx9ioVqotFGSfBD3LHF/9p+ZRb8h8sVOMHFZiN7VwUMq3tmmPasZfX2f
         8tM/Y+V5j1Sq/ECFKhPY3Xk5LyGWDGQ7e+ocIdO1201TFXseXksJXGXVfBVQgZWKq/Gw
         eUfVj5pL2Uv4N3aXUs1NfaAtxKldWJRRfzifWJ2Xqm4qcUXj2LE//M00OUt2Rdb9Py6e
         GvzQ==
X-Forwarded-Encrypted: i=1; AJvYcCX66vidcBKSyVtZPzprlHVJrKwesog9jqXzTZ3O3470GqMv/1RVK3qTcN39JKVEoWRN2c7uM5HWLuU5OXUu4S2IMycOHNbLDQ/jsEECCJLqT9RiGcRDsZjlsg7vu9pDrVTP2BYU6w==
X-Gm-Message-State: AOJu0Yy0lHQEEDlTDbLOnVkN72/HmkELiuD3UgSc1tzNrH5XK22bnaK0
	oJrGJC1WWPL1FacHCt6b1PcyboDBpeXy3mzqodNF4E3j/iSPq7DI
X-Google-Smtp-Source: AGHT+IF9dG5BwSTQD03rkROc00ErVNht2yV1WtWbGXemgrllsq31QSL+oNbku2+JddTKt1na1aXRhw==
X-Received: by 2002:a17:902:db02:b0:1ff:493:8de1 with SMTP id d9443c01a7336-201d63bc2acmr6884165ad.1.1723575722165;
        Tue, 13 Aug 2024 12:02:02 -0700 (PDT)
Received: from localhost (dhcp-72-235-129-167.hawaiiantel.net. [72.235.129.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201cd1a93d7sm16985145ad.149.2024.08.13.12.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 12:02:01 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 13 Aug 2024 09:02:00 -1000
From: Tejun Heo <tj@kernel.org>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: Chen Ridong <chenridong@huawei.com>, lizefan.x@bytedance.com,
	hannes@cmpxchg.org, longman@redhat.com, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next 2/2] cgroup: Disallow delegatee to write all
 interfaces outsize of cgroup ns
Message-ID: <ZrutqDox2rrr7dlA@slm.duckdns.org>
References: <20240812073746.3070616-1-chenridong@huawei.com>
 <20240812073746.3070616-3-chenridong@huawei.com>
 <ex5gnhcoobbw74se4uchhqj2lsrcjx5bsh6m5lva2xmujv7uae@34vwukkwhkbc>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ex5gnhcoobbw74se4uchhqj2lsrcjx5bsh6m5lva2xmujv7uae@34vwukkwhkbc>

Hello,

On Mon, Aug 12, 2024 at 06:57:06PM +0200, Michal Koutný wrote:
...
> You could also have increased the ancestral limit (if there was any)
> echo max > dlgt_grp_ns/pids.max // similarly allowed
> 
> If you're a root (or otherwise have sufficient permissions) and you can
> _see_ an ancestral cgroup, you can write to its attributes according to
> permissions. Thus the delegation works via cgroup ns (in)visibility but
> cgroup ns root is visible on both sides of the boundary hence the extra
> check.

Yeah, the intended usage scenario w/ NS delegation is that the delegatee
won't be able to see the ancetral cgroups beyond the delegation point. Chen,
is this from an actual usecase? If so, can you describe what's going on?

Thanks.

-- 
tejun

