Return-Path: <cgroups+bounces-9950-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C489B51DFA
	for <lists+cgroups@lfdr.de>; Wed, 10 Sep 2025 18:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E56A71884593
	for <lists+cgroups@lfdr.de>; Wed, 10 Sep 2025 16:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7C9272807;
	Wed, 10 Sep 2025 16:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="RHS/O7Wp"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674C0271446
	for <cgroups@vger.kernel.org>; Wed, 10 Sep 2025 16:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757522391; cv=none; b=ex+3XaeeoYYDRQer5VfaSMzcOKx/6VnVR2KYUOhh14HE14VvdmA0CDdOqPq061JvHN+5Dw8MwUMY2uN4TxdW5104+apcF1MEySIOS9XD0lA7KHxLO6GJ/M1ojIECRlsfKPlGY5OYMelIRg0K0NhroT0k+XLoES7uTjMVuuBrr5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757522391; c=relaxed/simple;
	bh=hbjFWc/M1u0JtUeGDfraCyEfZ1LuYrMt6ic+SN3g7Vs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uC0kTn7hAiOBCNFJxAz/DFed6tMby0/lriP/1ZW7j7aidBe5AhLJNtAOmHAH+pR5ntEwlnCPt/GIUKmXHXv2V6pntGc5HZiWzhh9XndUYhmxgVhqcJRpFn7tWw4VydrOo7DC3lMZBGEKnS+ZfRj5LE2L79jvekCWXVAdYDUczbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=RHS/O7Wp; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-40c8ed6a07aso27395825ab.1
        for <cgroups@vger.kernel.org>; Wed, 10 Sep 2025 09:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1757522387; x=1758127187; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/+f5haOvY7V5aJLRvqMe+OKgyMJap2D1kg9AHRnXBFo=;
        b=RHS/O7WpW2bKu3dkD3GuvUB5YTGA6gb7LyRfu04M+JBfGeQSuhkT/9v/nk/R+dCoyX
         mZsi1sKflT/XdZwHcNBieE1AylK3Qix8qUwrzhYZBj750TLxjVeOdcOWZXYvcj2GenBj
         MSoClkJ/PsF+80kRfPRItEj7Tm8QePGqSzJ+QsmXJFA9doy+ahyquicL0MG8caYp2OlB
         12byJ3aQN9mNWsdieeNi/AazOX86gv6oqRz8IP9rkgCUTTxmZp3BM2oUxPZN3vW0lahe
         xvDFzSbVRTFzXeitmxBk2z2OUGa+MHihFvw3YurqqUNqs94s3BNYsz99KAOAQOFDWNFA
         OV0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757522387; x=1758127187;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/+f5haOvY7V5aJLRvqMe+OKgyMJap2D1kg9AHRnXBFo=;
        b=Vqff6TDbw2WPYrAJX1qQLpG0JX07LMy533UvaBLNAlYRLr0/KbNkSC2qLAL6P3rDWX
         REskAdqk+xmdvhx3dfiT2vT+/oI8kp7hBc5W1Ez/RNq58QcrB8uxU1fxtveQyilPiUNb
         uQCyMoKegLi7+XQXhS0RpxPcAy/YI7EyqYwcxYwSXXyGjMm0sq3L2cy9bZCpiA6akIIw
         MbUkkYkPxWcr3Q9kIwgg++vIfZEIk9zeubWljflbIii7KKYfU2nX0XEMF+yOsI38I3rq
         kH4qDM+Z+nje7ktqBDzgG3b4f+YBvMOBoDg5w0h92Gsrn4Hmyb+KDxqaBG7G+4lq0SDG
         ekNA==
X-Forwarded-Encrypted: i=1; AJvYcCXTV1ohaMqNt4QZZdFGzwlPGvucM+/dHdT2AOpLOmAS4DS1Rs7QS2hWu4YIPc3KIBlFivAv9Rit@vger.kernel.org
X-Gm-Message-State: AOJu0YxThI5hOJQbdzJzSseZ0uqFH+QHFRpqNYSA+ZRtapx5xlzpnuc8
	qGklAkxhQUuSzZP7wlWHs+KKwx3wdBio+Xdhnp0qjsYDGJXW21V+SYX6w778dG7B8Pk=
X-Gm-Gg: ASbGncvyuoKVHEQJXLqTUur2MPhZ3ctUVEsL0wBuoTD5xJJMYw+xK+LUkCLOhQ8MyKE
	Qj8YbWYyYitOt//QZsBICS49qutnTNDUAi7kgaFbSWq37Bi+F2x+rJkpYLW+wYfJ+rccrxOKYSU
	Bic5rmQBP4RZwd2bZEPzUSxfXRIfJSm190A1ePjgD6IkLREHu/qzuXDtiZm94VqRFReQwBF/KuP
	VXU/h7zVBgb4YRu+q4WFx1wD2VUzLj1dV4BRkxld2lPMSVpYJWMvMki4RRSU+axkWI0NkDo4WA7
	0c5aqwaCuE2o1k3oiez+mvgQHnCb3pp9AgRT1D6FZFVNB4N53h5tqX9MTvasy0qIFIZfUQCyLzs
	1v1ONwg1C1jRnH6ErUwY=
X-Google-Smtp-Source: AGHT+IEb5WYlYRXj9KAGrUB6b6ycfigzKegEaHb0jkZarvr/Z/Q5oCi/e4o3PHKyP6WP+mXNVGSbxw==
X-Received: by 2002:a05:6e02:1a69:b0:3fd:1d2e:2e5f with SMTP id e9e14a558f8ab-3fd86264465mr231635655ab.21.1757522387509;
        Wed, 10 Sep 2025 09:39:47 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-417c8f03f9csm8607825ab.43.2025.09.10.09.39.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 09:39:47 -0700 (PDT)
Message-ID: <a2d770aa-737b-43f5-8d1e-0c139c09dc0c@kernel.dk>
Date: Wed, 10 Sep 2025 10:39:45 -0600
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/32] block: use extensible_ioctl_valid()
To: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>,
 Mike Yuan <me@yhndnzj.com>, =?UTF-8?Q?Zbigniew_J=C4=99drzejewski-Szmek?=
 <zbyszek@in.waw.pl>, Lennart Poettering <mzxreary@0pointer.de>,
 Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
 linux-nfs@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, netdev@vger.kernel.org
References: <20250910-work-namespace-v1-0-4dd56e7359d8@kernel.org>
 <20250910-work-namespace-v1-3-4dd56e7359d8@kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <20250910-work-namespace-v1-3-4dd56e7359d8@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

