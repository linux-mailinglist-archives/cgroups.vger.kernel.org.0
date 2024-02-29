Return-Path: <cgroups+bounces-1925-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B8686D4A7
	for <lists+cgroups@lfdr.de>; Thu, 29 Feb 2024 21:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DCA61C21FDA
	for <lists+cgroups@lfdr.de>; Thu, 29 Feb 2024 20:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD62156D3D;
	Thu, 29 Feb 2024 20:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CIJfwYXJ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06169156D31;
	Thu, 29 Feb 2024 20:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709239111; cv=none; b=FScUly3WnE7Axy4005TCP/FYxK7m1SraqJV5yOW+RV/RgeqYK+Z9DEahmHO335kx1Lda5al5Uc9WryWUyIhNEPuCP3PFwiDaYwpeNzmNGkpSn9JFhtgtNG0fflr0cRLdyygtgA1o53Uzr11zK5BeAbl5WRjPuaSE+cnUhH4KU+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709239111; c=relaxed/simple;
	bh=eSg98sjt7aRu+w+i6zQE4mpmeGRBJu3v1N/Ulj64Yaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qi2PuCG6FFC7GBOacq0rh1FQPBNbVU7DMnIIEusHdQm9THoTJwrtKuC24cSMVtmrskOjmx0ana3jaebr/CoQIquQLZ0bXa7N7WuTl9OBAFLOzBkmKVA0D4MPziCy/max80S0+9HyJi61MVFhJS24bqBDjTKm3dBk6gUj1q6DRCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CIJfwYXJ; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-299354e5f01so2020977a91.1;
        Thu, 29 Feb 2024 12:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709239109; x=1709843909; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3lG/LT7+3PcIB/iOfBuZGUVtLVxEz6BzHTsZ3utL/eU=;
        b=CIJfwYXJKCklU7+6aORG+sxbmFvsGCIwN8+upNp+XESh5f6C5aZjlpFZMeAnAfhVhO
         +iDQkIVZCHExr3FJrFKUDHfuw4IUDBc57Cl5dKY3kWB8IJfjhS08FZtgaSlTM6RED7h2
         B6Zd/MgH5qckBbqmpWrn8tGb3BRDL0J3QrdvMEGXvsraR9uWxbO+HXoVOrgm339POPLh
         R0/wQAnReGBOJYfazXMygdlKt1e/Ce4ibQ1P17zyqKHbLSQUtXtqCeWoyHvubjKAWMkU
         XT2n8VuK4YgKvWJ1+8GjeLn7jggR5lSxGGYrVKTHxEI3gFPjkpC2f0zFX7IgKE0T7c2g
         Xhdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709239109; x=1709843909;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3lG/LT7+3PcIB/iOfBuZGUVtLVxEz6BzHTsZ3utL/eU=;
        b=j5IRJSS5dFk5qNZs9GdspgTTbQmCwSC/s0HVS+lnxrkort2oUcVygBkp3os2DXf0tp
         MfI8CRTrqXGB3VyDQV8OZOykWuBs79hzeQvaENe7SsktzlDjgB5zw9/e0R+b0haG2oTU
         rHpfjewfnkWO67TxnEpCx2AaObM1ZhtWSyE6kRYulaZyXrZUi0SHo9EylZn+mG6Uu+Hq
         EWrCd6pqdaQIOajnVEvUQkkDHjE+KWubidn9fBhEtbUfzttxsxPgZFR4pCHD6iekRA9N
         IYUrarS9XfnGindkiRiFHluEIy7twV6y8lPE3EFQZVIi3UPbAqd6sB0DGFENJHN0+LCh
         o4gg==
X-Forwarded-Encrypted: i=1; AJvYcCVOzNFoETdj7FCVPhN4Xae3hC8NJdedDhH/t7fTX4gNORKBaUsnqAYDlc8tmcy3mwBvsph14KEpyemeTIZ/UfvgShQL/u+C373U0xWioaMNeBLrSo6Hojw42o+69JUwgMujnDnkMg==
X-Gm-Message-State: AOJu0YwmI2rNGHeVbc+FjhziNZPzqqFYXcFoR/ZJfoC76Rce3NbvyQo8
	f6+8w62b4VrHVjtGsP9QUSRjXzS0IOxYR0ioLfqaKK31pmRdDyCC
X-Google-Smtp-Source: AGHT+IGhRDhVSX6S3gH8ug1BgIIy3hfcEVYtLNzdTbhvxQpwCPUehtphII31vkVKc5tfPp6Acn5tWA==
X-Received: by 2002:a17:90a:6c47:b0:29a:decc:711f with SMTP id x65-20020a17090a6c4700b0029adecc711fmr68384pjj.20.1709239109352;
        Thu, 29 Feb 2024 12:38:29 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::5:8305])
        by smtp.gmail.com with ESMTPSA id u8-20020a17090a5e4800b0029a56afe382sm1898967pji.39.2024.02.29.12.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 12:38:29 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 29 Feb 2024 10:38:27 -1000
From: Tejun Heo <tj@kernel.org>
To: Kamalesh Babulal <kamalesh.babulal@oracle.com>
Cc: Waiman Long <longman@redhat.com>, Zefan Li <lizefan.x@bytedance.com>,
	Tom Hromatka <tom.hromatka@oracle.com>, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup/cpuset: Fix retval in update_cpumask()
Message-ID: <ZeDrQzU29SlKU2hF@slm.duckdns.org>
References: <20240229101116.60043-1-kamalesh.babulal@oracle.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229101116.60043-1-kamalesh.babulal@oracle.com>

On Thu, Feb 29, 2024 at 03:41:14PM +0530, Kamalesh Babulal wrote:
> The update_cpumask(), checks for newly requested cpumask by calling
> validate_change(), which returns an error on passing an invalid set
> of cpu(s). Independent of the error returned, update_cpumask() always
> returns zero, suppressing the error and returning success to the user
> on writing an invalid cpu range for a cpuset. Fix it by returning
> retval instead, which is returned by validate_change().
> 
> Fixes: 99fe36ba6fc1 ("cgroup/cpuset: Improve temporary cpumasks handling")
> Signed-off-by: Kamalesh Babulal <kamalesh.babulal@oracle.com>

Applied to cgroup/for-6.8-fixes.

Thanks.

-- 
tejun

