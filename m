Return-Path: <cgroups+bounces-5297-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0AD9B3264
	for <lists+cgroups@lfdr.de>; Mon, 28 Oct 2024 15:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB3FF1C21D8C
	for <lists+cgroups@lfdr.de>; Mon, 28 Oct 2024 14:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1461DD9A6;
	Mon, 28 Oct 2024 14:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="Dxvc1QSJ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B3D1DD554
	for <cgroups@vger.kernel.org>; Mon, 28 Oct 2024 14:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730124138; cv=none; b=gT6kg0wdTDXJfGLKkh6sj8Gch+/GSwH2j9AoIGmakPheS7aZ9qU32rxvhwZfNS8SAizl7vTJ7AbxCGP9upAelLJ6qQ3NwiCYRhLsQPKh1Lx6Rw0g41G0D6b0MLOLc2hoMlF6wBRH3ivuZgaH1ZQE7abVHMXOjFmrKp3ohtLHL0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730124138; c=relaxed/simple;
	bh=6NtzaLHH2RkqvPGHKKHItqVlr0xA+NQ34K5IMBIj8SI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kQ98PTHUBmExm/3wfm3Y2M4w3ABAbNy1xErZNpQfbPQUSP9jds6p9pmSQQy3Cjq2WVz9ZSX3Ie2FTS12HEI7/JGFqaXQ4jdvUvnNWRVjir4TuiRA8Wz5CZ3wMnS2eZW+CzciGKA9X6vYj4lw3T+y9b/qITF8LMe+nPrLe8ZNSjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=Dxvc1QSJ; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7b150dc7bc0so338551485a.1
        for <cgroups@vger.kernel.org>; Mon, 28 Oct 2024 07:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1730124135; x=1730728935; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y+pTNTU0CbesNOJj7SQS3n1+ZsJxzXX/EguUPHGGqgw=;
        b=Dxvc1QSJ0ZlfUeHEFak9pl1ybz0uBBuW7WGZmCb5YIP+IS+cooc8Rin4T4OuTYfdwJ
         /am/YWkFjNhe+tPkgqB4g4VVB+mKmVt/AQn1auM9GyQh1jC0PeWwnIOhTn9cxJR1DIyK
         beN4cyetdPxClTvWpmVuWFTx8wrc5+KCXUEU8UHtEp51mogN0CyLArg72N5+RQbTny38
         wxTSo3ZglAk6hO7zXnoinVN8cWFK8xHBZzMX8zs5ez17jQUt2/UkskZj1XC7sfHJMW9J
         Q5Rt1wripWKQ26vNIIHfsqL10iNSqJG0n0dWXyBY+vSWTt7C/sKSpidoWY1HuOSaarqm
         3mfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730124135; x=1730728935;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y+pTNTU0CbesNOJj7SQS3n1+ZsJxzXX/EguUPHGGqgw=;
        b=ai7+niUYocBaSVnJbimaXYFqUTpmdt70Uv71emj9LTWi1lZEYijusi5EHJsRDoaToZ
         ooL7hNCC8Fv9ZIUE7bNPu3kUsCCvWht6Fo6znaRIec/XwivPVHxnGi0ItaOCtEq16cHo
         ubLOHl+klZXisNXU6XIxTkN/AVEhuWelPzs/+9yCB4FZ7oN8EJGMtCrheClJwwiW3HM6
         eFd53buCZVR4NTlfaqqeTqa/bl3aLAwZPrUUVVhOiXZ3GFtxZHTfOjPQzJcb51Wzz2tk
         DfV3CVpDKHZGytj4YxaG7iXndRs+RJTN0f705KzeqDWCjlj8cfSipZi85gar7u8nQ+jO
         ZlZQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+grWtg3VF618CxSdo6RMCfTST15lLdpzQlTpW2NT44o+ekCuWrbFRFdeY+wf5uQZ+AOjcDENa@vger.kernel.org
X-Gm-Message-State: AOJu0YxebHO0JHqQZNwg99DhKcA1yPDaKMQ7MtUbXVYorWYhkywvoeS+
	3bGMLmRkXL8AI81J1tNVywmYUu7JY/yfuCALTnlto+Gu4AluhXr8KKZDkrolbB6E/um/tijriLw
	H
X-Google-Smtp-Source: AGHT+IER2ntkwj9uxtuQo4z+LCNsLMLN2s/pMek6zbEe6YjeeDquThbGY2qzmQ0x4cZ1k/agoHHi6A==
X-Received: by 2002:a05:620a:4504:b0:7b1:49a4:d1df with SMTP id af79cd13be357-7b193f5d447mr1346573585a.53.1730124135325;
        Mon, 28 Oct 2024 07:02:15 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b18d27a47asm321848585a.25.2024.10.28.07.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 07:02:13 -0700 (PDT)
Date: Mon, 28 Oct 2024 10:02:12 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Hugh Dickins <hughd@google.com>,
	Yosry Ahmed <yosryahmed@google.com>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH v1 6/6] memcg-v1: remove memcg move locking code
Message-ID: <20241028140212.GE10985@cmpxchg.org>
References: <20241025012304.2473312-1-shakeel.butt@linux.dev>
 <20241025012304.2473312-7-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025012304.2473312-7-shakeel.butt@linux.dev>

On Thu, Oct 24, 2024 at 06:23:03PM -0700, Shakeel Butt wrote:
> The memcg v1's charge move feature has been deprecated. All the places
> using the memcg move lock, have stopped using it as they don't need the
> protection any more. Let's proceed to remove all the locking code
> related to charge moving.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

