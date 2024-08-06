Return-Path: <cgroups+bounces-4107-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4F8949737
	for <lists+cgroups@lfdr.de>; Tue,  6 Aug 2024 19:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A2D81F24108
	for <lists+cgroups@lfdr.de>; Tue,  6 Aug 2024 17:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8453176C61;
	Tue,  6 Aug 2024 17:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="dfdWBFOl"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4CF7441A
	for <cgroups@vger.kernel.org>; Tue,  6 Aug 2024 17:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722967143; cv=none; b=ieLozC8sHJoY8iztQtoUpThXAjJmcI45r2FVtJK5dTuZmru/NMNWvgZYfkJJ8WLxd4KmmhS2LNfX5VDhi5NO7V3V6Mr8YuhokiGBkiRMhc5ndln6E7qHdVY66oQCgYfb2JLMFDyJcS9vF/ONcoi70LU28x1z62cGVQpaBddnMO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722967143; c=relaxed/simple;
	bh=Vr4ssX3LexIo2N6PgFRtbpKq5//JSwMuoHCZ2wWW88c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AQcP5vmPxapQbozFbBVTl1O21Y5uT/cQaltTSDk/F4hPqSEELgV2N4LYXfdiQiHeF1Y2eq4ePAAagaOWJEVf6O/2BHsT9/K3vKzNlmcSQmIXNIktdYiAMKyP5HEIKnUcs8fzgTFHRsPkC23jeieLjQMxr3anrfIXMkPZ6LHC9o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=dfdWBFOl; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3dc16d00ba6so490161b6e.0
        for <cgroups@vger.kernel.org>; Tue, 06 Aug 2024 10:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1722967141; x=1723571941; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9reD6LjBIDqI3rzCI/2rJ/w7uTHYKxSa2MJZ9OknCy8=;
        b=dfdWBFOlaaALwxoIKu0QSosUVGXBLx4UNDbO54AvopPTo9IOW8/NzY9mQXQfJfHnpv
         7S+3ol2Kbt2hYwvLqhGzwl9aquRu/80zuvfXeD6qaKnefoTHn1mRUmb9tw2IRpaGYVcz
         V731EOf8WLioZ7giCcg44U6TR2aJXJi3q088YwzTDxAI4nRl32JY5XDG//QtE/QCAnj5
         cPgbU+W8RIW/rSq2Aun0u4bDRnnVGQ9BM+BabAKkBk6oy0GLaUZju+XBwww6a/3e3Pbq
         MVMTU9QkSngPFAzPaeeQAhEkOkJJcOEKOCznKXrrmloa7gGU1ZZOb6mpSfSzE3Spsaid
         fplg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722967141; x=1723571941;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9reD6LjBIDqI3rzCI/2rJ/w7uTHYKxSa2MJZ9OknCy8=;
        b=FW9CsW035OK+inq3nw78tUZ/VPNKZjMD4ASFXFuwglYS0bA0mxAdVQoS/Iutonn1Zw
         FuTr6VIiCKrCDhDHUvQWmvEW9BhkkPfr5LNqxTrvTQhfAQyuzSqyGcsqOkQ9yCtoGdyO
         bpS8T1I0k7mQviYfBJRPHBYWttMGvCLURkv8jnf837mpG5vvIJhSMI/mRnbxXKpjZ5MR
         8VOEz/piapzaN59XqONUlWGQmcc/S7U2gaziLJGcSGRDPyWP2lmlqRLZRZo82ZhVk2qg
         Npyiz3QA4mpucVW2TUi0zv5tsKTvjF1SU2A+0bATaI0dKeNLVY4d3DEdzot7qE9i02ws
         B03w==
X-Forwarded-Encrypted: i=1; AJvYcCVQ9kGHR/gDHfdeDSCYOCKteNmN7sejEXu/C6nEjTNG+6JXorYomF1dVzNPRbWb+HEc07gkJf3TWgU/pVna6aw53x1VRlNZZg==
X-Gm-Message-State: AOJu0YxrDq5QfX67+jfo/9VfHRmThSeKICHU8LZ+ZBlIvCJv9cYL1QbX
	Y+ceh/LlEX5mKRrWB6BOe9T7oGlnU+gdWn5med714sMHW6TEuFLu9Yy7zdFNbKM=
X-Google-Smtp-Source: AGHT+IEwktuJ1CtYSzQb94QGzgaDodUnXytdXmjscinDnu4jw335ZRMBxJxoUFxjs8sU40IQz5cmUA==
X-Received: by 2002:a05:6808:2212:b0:3d9:e1d1:157e with SMTP id 5614622812f47-3db5582e299mr22117856b6e.35.1722967140874;
        Tue, 06 Aug 2024 10:59:00 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4518a6c547asm39893111cf.30.2024.08.06.10.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 10:59:00 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sbOSZ-00Fhpe-RT;
	Tue, 06 Aug 2024 14:58:59 -0300
Date: Tue, 6 Aug 2024 14:58:59 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>, bpf@vger.kernel.org,
	Amir Goldstein <amir73il@gmail.com>, kvm@vger.kernel.org,
	cgroups@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCHSET][RFC] struct fd and memory safety
Message-ID: <20240806175859.GT676757@ziepe.ca>
References: <20240730050927.GC5334@ZenIV>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730050927.GC5334@ZenIV>

On Tue, Jul 30, 2024 at 06:09:27AM +0100, Al Viro wrote:

> 	* ib_uverbs_open_xrcd().  FWIW, a closer look shows that the
> damn thing is buggy - it accepts _any_ descriptor and pins the associated
> inode.  mount tmpfs, open a file there, feed it to that, unmount and
> watch the show...

What happens? There is still an igrab() while it is in the red black
tree?

> AFAICS, that's done for the sake of libibverbs and
> I've no idea how it's actually used - all examples I'd been able to
> find use -1 for descriptor here.  Needs to be discussed with infiniband
> folks (Sean Hefty?).  For now, leave that as-is.

The design seems insane, but it is what it is from 20 years ago..

Userspace can affiliate this "xrc domain" with a file in the
filesystem. Any file. That is actually a deliberate part of the API.

This is done as some ugly way to pass xrc domain object from process A
to process B. IIRC the idea is process A will affiliate the object
with a file and then B will be able to access the shared object if B
is able to open the file.

It looks like the code keeps a red/black tree of this association, and
holds an igrab while the inode is in that tree..

Jason

