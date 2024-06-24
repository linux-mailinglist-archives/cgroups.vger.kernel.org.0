Return-Path: <cgroups+bounces-3307-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC229154A6
	for <lists+cgroups@lfdr.de>; Mon, 24 Jun 2024 18:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67EF628602B
	for <lists+cgroups@lfdr.de>; Mon, 24 Jun 2024 16:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D64619DFAC;
	Mon, 24 Jun 2024 16:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UqVzsasY"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3970D142659
	for <cgroups@vger.kernel.org>; Mon, 24 Jun 2024 16:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719247607; cv=none; b=oHBY9kdJehlJiTDlxC0nOu1XtPrWEWiv2fLns6KfsN68rwxBEF6OkdZKg3voINWztUpjrqNJ5B7Xniw9vESAkalqFvAih6S0bizntnjTPAo64mNxDJ3Ui0t4IdukqCjyO1pld0OqKvDt3ahqdinjCOJogMTqcXxIEKEeB5NTVUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719247607; c=relaxed/simple;
	bh=fKtutG1GdZlzjibolCmXSp5xe1fv3mZtm/w2hM6+lKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bHY8QyX3xeMo/vqmHsG4/Wv4TENpKoqkBqS1XL/ztoO1y/NfVRPPH9F6V6cyxqfyXEuOVIDw30mZf40geDwm4tyjB1+xPpoTOS1wFnR74rBAedAB9jcmYRiBX/8ZmtvvPfyissFmMWi7y8MnbGM0qZ0LJ0jMtDaymO9OmJieGjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UqVzsasY; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a72604c8c5bso96201266b.2
        for <cgroups@vger.kernel.org>; Mon, 24 Jun 2024 09:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1719247603; x=1719852403; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UdsQVLlx/h6bzQBw/PftMKrwboL2BwJ/wPUlBpBpDJU=;
        b=UqVzsasYbbxyXI3D/wZwFkmWTyMpR7G356gHGr0m2JoO1S2sQ62EV0tvG7rL74m/Y3
         M15OG3GRAutabSIm8kY9phVDTvPfT20TncYmL24PCASuBY7YqTpq4abGbskOQBF75uGS
         uZNLFcL9wGrlMhiiQoE/e/kAxwxTyM2JUmr6hEljshGv8Zi7schkPfYOuvapYKnEzTT4
         dRjyfodfHMIdjeNCFyImR+j+QOBioHCsJRXluIExAZRMaDeJaZ3DgO01qJxEmRndcNzY
         7l1REdC4VVklMDBvERe+iyuO/B3WuL0i9MTmvhIhTE7hTsE5Cukbz4kzebAwspE+HHHm
         xTUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719247603; x=1719852403;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UdsQVLlx/h6bzQBw/PftMKrwboL2BwJ/wPUlBpBpDJU=;
        b=pg9MlI1j4lZlCdB3nmThZ34Bow9ibXfrCngxp+KfGccsb8BILuzbfNJcfS40BLyB0r
         fTkL3TBlkhGdGSO7KiU+8qjNfftyd8ok3YSP6Qb1QAREphdFIehJf3ovafUWql5/Eq0h
         OaxN9ZXqc450Iwq4qp/UQHEnwsBlaJ7oY9Qy8Z2N2ENqaKh/Ge5Kwgp+G0+ifmftcsqm
         ZeWTivJHmas3abc8zaXAKFuimYPJbpeVbK/4gQuh9MAMOxvV+4RNdugSO306/rryl1tl
         0ionqh1cI1AfsBOak81lUhmcHZdhGyG2UVUTX+AMt8w6/J5QYIcCDZvRTffYs+hnGnk3
         jxlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZF7lB0LBCyXcVRvSOkrIgF9llLlS9CjfKrOnLV5IYJNGfs5EDRzXJb1s+1CQxji+0YdqBkdAuy5LT98gTqJL+t/82yUEl/g==
X-Gm-Message-State: AOJu0YwpBoooLzlNtXkEeKeaTlluy+BRX+mib/VZK9DDzo+mTnIYVF8f
	2C2RT1dlhvmh9EqPYkaERJVsMukL7EYg3GzQH9tqrmwE42XlwJa8SSpc7gCFC5VYAum2fmfDzAj
	s
X-Google-Smtp-Source: AGHT+IEeKvPzfyNwPxeUyUIk7sVc3A7I3ZiIk2CwSjDSZ1RvoC7EvcXrLGH4uX/AhGcrQmx9KSgf9Q==
X-Received: by 2002:a17:907:a809:b0:a70:7a10:de0b with SMTP id a640c23a62f3a-a7245b565b2mr352681166b.21.1719247603444;
        Mon, 24 Jun 2024 09:46:43 -0700 (PDT)
Received: from localhost (109-81-95-13.rct.o2.cz. [109.81.95.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7213f474e0sm273562966b.190.2024.06.24.09.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 09:46:43 -0700 (PDT)
Date: Mon, 24 Jun 2024 18:46:42 +0200
From: Michal Hocko <mhocko@suse.com>
To: Waiman Long <longman@redhat.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shakeel Butt <shakeel.butt@linux.dev>, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, linux-mm@kvack.org,
	Alex Kalenyuk <akalenyu@redhat.com>, Peter Hunt <pehunt@redhat.com>,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH] memcg: Add a new sysctl parameter for automatically
 setting memory.high
Message-ID: <Znmi8lfORdPoI061@tiehlicka>
References: <20240623204514.1032662-1-longman@redhat.com>
 <77d4299e-e1ee-4471-9b53-90957daa984d@redhat.com>
 <ZnmO8izZPwYfiaRz@castle.lan>
 <d97e2e8f-0abc-49a7-bead-0501c1226040@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d97e2e8f-0abc-49a7-bead-0501c1226040@redhat.com>

On Mon 24-06-24 12:33:27, Waiman Long wrote:
> I also trace back the OOM problem to commit 14aa8b2d5c2e ("mm/mglru: don't
> sync disk for each aging cycle") in the MGLRU code. So setting memory.high
> automatically is one way to avoid premature OOM. That is the motivation
> behind this patch.

Please report this.
-- 
Michal Hocko
SUSE Labs

