Return-Path: <cgroups+bounces-3425-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC50891B129
	for <lists+cgroups@lfdr.de>; Thu, 27 Jun 2024 23:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 193B71C22351
	for <lists+cgroups@lfdr.de>; Thu, 27 Jun 2024 21:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE1F19EEDD;
	Thu, 27 Jun 2024 21:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ehQSvO3x"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72E613FF9;
	Thu, 27 Jun 2024 21:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719522412; cv=none; b=S9znzff+5oNSl0v2Tw0mKqKyV1mD7bUg4AtFCoTIqnMJP1T6mR1SL0j6cEYqTcSSYT8QCQTAFxI2y8j4XPXaZGpNGcC7qWxuLXMDfmM0s6o4xrRRugeh/XTwJZKHzSMxAeXNKxJRBzhce2qUqXJ+ljui1MgZ/FSBdgqOCEgnN50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719522412; c=relaxed/simple;
	bh=DDPfdlO98sdlhtF9kJaZIH3v7M3WHLdcMJZa65Papyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sast/ddi9iFGA7By9yQjOnJEbik6mkYsgYdRlNOyJlt+zX0MiIuWaDQAOZ6n7/1mW8Ct3KVVQW2bsKVcCk4AgR4Kx6WUH9GxWA/u76iLXhOViOBNjadN/0Le/S1fXG0g6cXK/G9RhmGFaoXIAz/ypJZqGiOD7h1lEHeY86VFmfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ehQSvO3x; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7067a2e9607so4437252b3a.3;
        Thu, 27 Jun 2024 14:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719522410; x=1720127210; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ip+XQJ2n6yPW5qOV564CObPrlBXKrF+ckbuNWNnjDBY=;
        b=ehQSvO3x2+4xZ5Ww7TsLzKl0kS35J53+J/3ubwLGlqikZX+pQXfBHtEeDY+HHqK69F
         QqtoXndE3dA1HNJijOzBgeHtITZ30cSW1qf+2wilSffmrS8e8f/i7CONQ1Si/9bB5OnI
         o7/W1DB5+filWHfqln7BpPfR9jcuazOSu2SZYW5/icfejwajEheMKEuQLtACK9GBA1fs
         mhhjrIFdq5b1IO7yrdzWCrnRBcZUiQ5yc4vvEZV/B8VKPZfNOCmnO6+2pjUIqIUiNLdi
         9A8H+ItVXsB4ELtXS7uoZ5+lNkqyOspsf+QTzrHwNqDxfV86sJ49hePZw8Po68oYOTfj
         h9Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719522410; x=1720127210;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ip+XQJ2n6yPW5qOV564CObPrlBXKrF+ckbuNWNnjDBY=;
        b=oYs36lQqhzgPg7M78QGdBPQuyZV8xIHBDv1dSuKDg4HZdUCnsQlakV1A3/L1sfBNyj
         FwL+IvqiCHMAWU8wn/J4OXEBekEuEmvHipYE36dh0vaNVk0zko8DOierTAp4jfEOJfp3
         O21fjIDe7haknxJjzd4C1pObQLdXvqwOKOynr1bG3tn42jaxyCEeFgyNhrAZ/eqbMthN
         c4Euu1GW3n2EOgUtfbkSDKW56cOjgQoZqj/Ny+pz69BKMU+7SwmPbbsW8nIadn6qr41g
         k3P4BzSrd7k9iJToBW2wo/wM+1Tz/vBDalRaOdq9/v/bLDgZbqSrft1wOFkWWYOWqenn
         9idQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsBlXxfOp/xDvRRq7VsvrO9O/5uX/xCdqwzYvkUbSpOYIjLxnqEEQoA6wCZWWHFxsh41VZqhUPQswuPLaFAk8Xv0iy2uYzXNwOEvRcM9/mIBLgehaqC0Tt8LPAx7SlECroyiQLyw==
X-Gm-Message-State: AOJu0YyNHYVwpVB1z1RfusoCkE8mJ6j82ezrXPvtnzettjfyYvA0pIx3
	860jn3+drnwWTp9Dt0QIwGfO/t3t2tw2RNsuHCUGia28dO//1yZW
X-Google-Smtp-Source: AGHT+IGKRdwJZHZaioM88FQy0EHeajn7jcVzhE9o1K73BQa78E4ny571j2bJ2uUJGKtAKQWTH9jw7w==
X-Received: by 2002:a05:6a00:21c6:b0:706:8a67:c395 with SMTP id d2e1a72fcca58-7068a67c574mr17006572b3a.6.1719522410041;
        Thu, 27 Jun 2024 14:06:50 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7080498a3besm159878b3a.196.2024.06.27.14.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 14:06:49 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 27 Jun 2024 11:06:48 -1000
From: Tejun Heo <tj@kernel.org>
To: Xavier <xavier_qy@163.com>
Cc: longman@redhat.com, mkoutny@suse.com, lizefan.x@bytedance.com,
	hannes@cmpxchg.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org
Subject: Re: [PATCH-cpuset v7 0/2] Add Union-Find and use it to optimize
 cpuset
Message-ID: <Zn3UaMouBYYIMQr_@slm.duckdns.org>
References: <Znb4JBpJoGZ3LS1W@slm.duckdns.org>
 <20240623023901.218892-1-xavier_qy@163.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240623023901.218892-1-xavier_qy@163.com>

Hello, Xavier.

On Sun, Jun 23, 2024 at 10:38:59AM +0800, Xavier wrote:
> I think I understand your point now. I have modified the Union-Find
> implementation so that the allocation and deallocation are handled by the
> user, providing only the initialization interface. Thanks for your
> suggestion.

I recommend spending more time studying the existing data structures. The
pattern is pretty universal. The element is often embedded in a containing
structure. Macros and init methods are provided to initialize the element
along with operations which implement the data structure operations, and
then we use container_of() to obtain the embedding structure. We very rarely
allocate data structure members by themselves.

Also, the cleanup in cpuset seems nice but, if you can think of other use
cases, that'd be great too.

Thanks.

-- 
tejun

