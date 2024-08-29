Return-Path: <cgroups+bounces-4554-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E09D9639D3
	for <lists+cgroups@lfdr.de>; Thu, 29 Aug 2024 07:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0BE41C21A5D
	for <lists+cgroups@lfdr.de>; Thu, 29 Aug 2024 05:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A078113B592;
	Thu, 29 Aug 2024 05:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="hTF0Rajx";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="g20h9r+k"
X-Original-To: cgroups@vger.kernel.org
Received: from mx-lax3-1.ucr.edu (mx-lax3-1.ucr.edu [169.235.156.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E114A00
	for <cgroups@vger.kernel.org>; Thu, 29 Aug 2024 05:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=169.235.156.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724908818; cv=none; b=DWSriixhwegmiQLHUjBruJxCMRasVXfV1mQcTvnFhsX4tFPScDXx2bREIyj/rEP22XMq62ICBbS9+rEnINf72kJEXj0mi7Yul+xru4E0RXqaALTuVR9ctSK1v17k+ze1khxeelQNFPVe0lmgjG6Uhg5QvTLmaUgg7dmRZGAhXhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724908818; c=relaxed/simple;
	bh=Ia45hZSXNQ+K+dqO1AXNRzWvtG8wWud4WxNi7CoqRdU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hmPX5DiEE4gtBZB8U4gnIpDyGhn36Ab4OQd6QCZY/E4Yl/2OCKd0jS1pw5OYR5TQR4GrgUcSFKn5xZip/sl8xL3DRidG9ZUfQGrb+v0+4LPPEA+g4MnSMUXTDRFDcvf4/HOAqyrjmQDI3l/zuahfpmRJSDpLbdA8ZtskJysdW7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=hTF0Rajx; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=g20h9r+k; arc=none smtp.client-ip=169.235.156.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1724908817; x=1756444817;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:references:in-reply-to:
   from:date:message-id:subject:to:cc:content-type:
   content-transfer-encoding:x-cse-connectionguid:
   x-cse-msgguid;
  bh=Ia45hZSXNQ+K+dqO1AXNRzWvtG8wWud4WxNi7CoqRdU=;
  b=hTF0RajxEcp6QyB8hh8/CJ4wSnw6bKIJ3M9L4VECEQyYI3ywdJ63X1io
   xZimQLsTojKvNv4Ca1Gcrg6lLzXhHeeBkOsXbq/4O7XdKZ/MJEUnuI1cX
   YLAWUWYkTrv1Y6moM/Ufy5HNUQ/QQvIyxqdhZXRlRQw3zifqYnMeSIUdg
   7ng+8lGE8/44/h/zVjCfzsXRa7oO+2Fy83NYaTAU2ytQEYmTOGZqToU2/
   9lWaaPino1T3h0s8k/MXeHDB8bJN12RG0H8q7mpm0Emrj85zP9uueSePw
   a7aNrEVW6PngY1LdABisRFkU0FRzR795es1gvII5xCuImPjqH55JK+b93
   w==;
X-CSE-ConnectionGUID: tS4wg9gBQLWM3kuWzm6vMQ==
X-CSE-MsgGUID: /Ki2C6e/SJ+xmuRkvDNcDw==
Received: from mail-il1-f199.google.com ([209.85.166.199])
  by smtp-lax3-1.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 28 Aug 2024 22:20:16 -0700
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39effb97086so2510405ab.2
        for <cgroups@vger.kernel.org>; Wed, 28 Aug 2024 22:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1724908815; x=1725513615; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oihb+ZEx28nXHc0pAbgch0ZW5vY7lh30JIgO8BQjJuM=;
        b=g20h9r+kHYr9ncP5VuZl81agnzqYsGQWhRGskvA2AlXn+VbdPgREtfS7qjJ1xtF7Sr
         nGsf8oqnL8l7X03OE72GFa91hFF9O+rObVSkigALFUpQPE1VbTAuD9HRW0d4cpwPXa5w
         XydAwBH89moRlLQDCyaSFA0mdHD3y03GA/Pvc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724908815; x=1725513615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oihb+ZEx28nXHc0pAbgch0ZW5vY7lh30JIgO8BQjJuM=;
        b=m5T6FpnQws26UT3mSRfkEpn+xqlUEO+U3/63ncJnnC4fbr5/83rGJINpiT8fhVlu0c
         f3o+KK3VvTurCBY4giTzWMFCc7qsRTL86TFycObnpt2NNVY604ex/sSexytCAifycFsJ
         7tF8uJgQDyjffoR4cNlR3nIN4iarluCAppEvbgGU97t3IEH5G/f3wpNATuxqGa7PA9Wg
         hOZ4zI6KOie3/2UfVBKKCGK+aqv514eZH39ficsvblubjSE9HZc/LWvHI16LkAUZ8tRX
         c2cMilV0vVKYvfBSlqQJE7NQ54a1e3cKxWJDA93luUmX5YhmubY8VxLH3/Q+OYb89KXT
         oVKw==
X-Forwarded-Encrypted: i=1; AJvYcCU0Ma1I2viW7CZlegzOdqPioGOXalaQURPNKjs9cDlm3uQikm9EmjnauJjqbUnLFDncJvKcqvTN@vger.kernel.org
X-Gm-Message-State: AOJu0YygoBBZc3Nc+6MflbDRBLSfIhX9Zy97Rz560ufUhrugWUxmV7xH
	Ssr+C6ZxGLNJupJQAJcXNYqEaaRxlZJIqBUFTX/UkGJfRVibdlqj1DszpX5jDykZfSEvlaYte/x
	9AkvVa//mvg8KmSSx36Hr0cTQC9Xarf1J6/j4oQY/GjctyqTSbcootaf2GUX0O+yQz6GUFq/mFt
	4Mvh7wiJnZtdLjG1hrPZlhwpTozza5ubI=
X-Received: by 2002:a05:6e02:184c:b0:39b:389d:f7ce with SMTP id e9e14a558f8ab-39f378ec19fmr20753065ab.2.1724908815352;
        Wed, 28 Aug 2024 22:20:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtw1BOlLUaOKprgVjlL/LtyLeM1+0tuUpnn+kK49YRBERx/P+NDQeXjxtE+TO094UecuMe95yJy/8UvktdhKw=
X-Received: by 2002:a05:6e02:184c:b0:39b:389d:f7ce with SMTP id
 e9e14a558f8ab-39f378ec19fmr20752935ab.2.1724908815041; Wed, 28 Aug 2024
 22:20:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALAgD-6Uy-2kVrj05SeCiN4wZu75Vq5-TCEsiUGzYwzjO4+Ahg@mail.gmail.com>
 <Zs_gT7g9Dv-QAxfj@google.com>
In-Reply-To: <Zs_gT7g9Dv-QAxfj@google.com>
From: Xingyu Li <xli399@ucr.edu>
Date: Wed, 28 Aug 2024 22:20:04 -0700
Message-ID: <CALAgD-5-8YjG=uOk_yAy_U8Dy9myRvC+pAiVe0R+Yt+xmEuCxQ@mail.gmail.com>
Subject: Re: BUG: general protection fault in get_mem_cgroup_from_objcg
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: hannes@cmpxchg.org, mhocko@kernel.org, shakeel.butt@linux.dev, 
	muchun.song@linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Yu Hao <yhao016@ucr.edu>, Juefei Pu <jpu007@ucr.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Here is the kernel config file:
https://gist.github.com/TomAPU/64f5db0fe976a3e94a6dd2b621887cdd

how long does it take to reproduce?
Juefei will follow on this, and I just CC'ed him.


On Wed, Aug 28, 2024 at 7:43=E2=80=AFPM Roman Gushchin <roman.gushchin@linu=
x.dev> wrote:
>
> On Wed, Aug 28, 2024 at 04:09:49PM -0700, Xingyu Li wrote:
> > Hi,
> >
> > We found a bug in Linux 6.10 using syzkaller. It is possibly a  null
> > pointer dereference bug.
> > The reprodcuer is
> > https://gist.github.com/freexxxyyy/315733cb1dc3bc8cbe055b457c1918c0
>
> Hello,
>
> thank you for the report. Can you, please, share the kernel config file?
> Also, how long does it take to reproduce?
>
> Thanks!



--
Yours sincerely,
Xingyu

