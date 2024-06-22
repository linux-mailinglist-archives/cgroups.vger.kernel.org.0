Return-Path: <cgroups+bounces-3282-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66CBB913501
	for <lists+cgroups@lfdr.de>; Sat, 22 Jun 2024 18:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14B0A1F21CCE
	for <lists+cgroups@lfdr.de>; Sat, 22 Jun 2024 16:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F62D16F91B;
	Sat, 22 Jun 2024 16:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PnFiIvtD"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D193D82492;
	Sat, 22 Jun 2024 16:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719072809; cv=none; b=YtCSoaK7FHLfxZedq61Is6A+VJLsXReVG4f3oDPfJXka+RzFATy9Swj293CInkZgN+U+qSLOqo+/uO5L6lie8mp5qUx7jlBKkQsYUcVyKDXn+H8QgkxBrR0XkvV3fIeMCSfZZ40zdueivBOgNbsiHyxecmMfARjCRqJ+WK01kKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719072809; c=relaxed/simple;
	bh=WEPGh2g/eR7cqZD7kIrQgVnoclyRVeCV0igVlLbbYUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dny72tWAaSqqZ8zTOAViLoeiitw70VyfnHWEXbSSrQTp78FtYdNqg2ikKkJktrAKAIjWVIw+MyYJxf+RHtDJia/Y33KhxAaCoEkMB6NreUPjbLzGIrezzXwDwHNmWmiBSoPRcggXQNVYMqeb0yzyjr9s9FsiiE89dzaFt1TUwNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PnFiIvtD; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7066c9741fbso353155b3a.2;
        Sat, 22 Jun 2024 09:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719072807; x=1719677607; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YfQgHJ9GHbuY/xBljEs+qzKYxxicnPA7xLZUoCwp3KU=;
        b=PnFiIvtDdoPLnhoSjZRzPl5/c4qOiN8ydKzZsLr4NMILyXT8SF2fnDSOwe6Voyxjjz
         rxN4QrGuuIHMaAAceouHv6/O24rvbLTB3E0KpZrAqHk5mtGGzS+p+rAXF6s06uyBJFZR
         sgOZ/nomaXmTnO+mUeq1jAuNRLaIt1nBqlsJuZVpBzi+mzv8IYDiakQLeXGzrbYa60Js
         e2uKELToRIPkf3cbwTRlKt+LWeLVdy6c3zLjevyISQ7/iw8dCPxRzjYjNIgqAULcJivN
         rc+C6BpQmKoG9jsdU1EmAEXdowt/nBazccNSUkkMuNl90v780Kwe93ovtGipOZQcQvGr
         ShqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719072807; x=1719677607;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YfQgHJ9GHbuY/xBljEs+qzKYxxicnPA7xLZUoCwp3KU=;
        b=sTv7x2E1kc2nKhJrdhtdciNezEwGvh5X+mBlvl3qAeCN633XrnhHG3CsEIMD7r52h/
         Ih0xwtLV34T5FSrdKQN7R5S3oWoN6ZdsGG2Efbi/y8Kh2OaCgB1XPQaMhNM1v+e/K17G
         s+86O8g4F3WRx2sd2qEgw0wfb0W5QHApB3+BIaFoW3K6dwysOR9bx6Lmvdx4JeG9jPFa
         wSzro3D0oqUb0+xTGszItFQtQLy4VKrAWA51NjpEiJ2EjHGhhnrQ6lzACiz2j7agI6+j
         8+7iG/pg1XJSXyyp8GSisfIRerRviolpYawNxCIRkWlxnBKsQn6kfodMHvoPU2U6d87R
         vheg==
X-Forwarded-Encrypted: i=1; AJvYcCX3y1Xb4KwqM1uJMVoqxDQmJAMYPA+xHRVwpSZ+03S2Hj6JwF4p00PtYzDKfhFAWFiHcWftdHMnZyXZWiX4EGvvW7FiiB9/d/x7E0gRmR+7JjWsH4Sh+g3/ZA5fIMYHv21fCEP/mg==
X-Gm-Message-State: AOJu0Yx/FM+xANbMPQSawmqPeVBA2V1MkCxpyuYB6iFSQOgIOnvUi6Kz
	S/Ha+ZQrvCA1ytmjFU0z50N88VdgqLMX1fcq+OUsi1gXBxf8CQXN
X-Google-Smtp-Source: AGHT+IE8B4FaBx/XtPGumeAi8GNlm74hQSGkUmcpTZ/rZCmKAZG0B8TeUkJQVX7/3a6xGquhb22Tzg==
X-Received: by 2002:a05:6a20:8ca1:b0:1b6:7a70:d46a with SMTP id adf61e73a8af0-1bcf7e7514dmr244180637.18.1719072806973;
        Sat, 22 Jun 2024 09:13:26 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7065107b62bsm3369411b3a.16.2024.06.22.09.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jun 2024 09:13:26 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Sat, 22 Jun 2024 06:13:24 -1000
From: Tejun Heo <tj@kernel.org>
To: Xavier <xavier_qy@163.com>
Cc: longman@redhat.com, mkoutny@suse.com, lizefan.x@bytedance.com,
	hannes@cmpxchg.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org
Subject: Re: [PATCH-cpuset v6 0/2] Add Union-Find and use it to optimize
 cpuset
Message-ID: <Znb4JBpJoGZ3LS1W@slm.duckdns.org>
References: <ZnXsUnAi7VnX0tZJ@slm.duckdns.org>
 <20240622071424.215778-1-xavier_qy@163.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240622071424.215778-1-xavier_qy@163.com>

Hello, Xavier.

On Sat, Jun 22, 2024 at 03:14:22PM +0800, Xavier wrote:
> To Tejun,
> Since union_find operation does not require contiguous physical memory, I
> have replaced the previous allocation method with vzalloc.

Oh, that's not what I meant. Sorry about not being clearer. What I was
trying to say was that requiring consecutive allocation whether kzalloc or
vzalloc is unlikely to work for kernel data structures. The reason why I
mentioned vmalloc was because it's easy to end up in sizes that require
vmalloc with consecutive allocations and vmallocs are rather expensive and
not that great - ie. having to use vmalloc may negate the benefits of better
algorithm in most cases.

Skimming the code, there's nothing requiring consecutive allocations. Is
there a reason why this can't follow the usual convention that kernel data
structures follow (e.g. list, rbtree) where allocation is left to the users?

Thanks.

-- 
tejun

