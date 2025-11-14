Return-Path: <cgroups+bounces-11973-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D31C5F3B9
	for <lists+cgroups@lfdr.de>; Fri, 14 Nov 2025 21:26:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0A84635760D
	for <lists+cgroups@lfdr.de>; Fri, 14 Nov 2025 20:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B0334A783;
	Fri, 14 Nov 2025 20:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TiYFqd0B"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7A634A3A7
	for <cgroups@vger.kernel.org>; Fri, 14 Nov 2025 20:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763151979; cv=none; b=gFqbGI42WLV64Jm62fQKDZaE3C30TKCN2S0g5C2tVMfQpoHZ5+PNtOs8otG9co4cdYB1vFYSHAsRtYmCTp7WeMBj34NUHvXGVfLpaqtPP0Qo2cHHrEpWNy75RsFJFLQZIy/0QzG7MIy3jFd+MtnQTxzJkF3E16GOk3ec1ngo3eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763151979; c=relaxed/simple;
	bh=UBXKy1JsF+c00Tx+eyE82c66VPELlnaIipoBvhQAyvw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MA3kedxdnDwx1zIJzKBfH8XZLZCbhWVcRlVYfl3DtRnRE1c7ftrJDfORDlV6H1nXc+TYxbie6lDw4k/3uicfN2EDQ8InHWbFryp1ZJqB2B2JQwV1eCcfy6gugGoEHqfvvqnU/tZqYPGHayyEegTlOEo50kr0zXvGvGk8SWzWAW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TiYFqd0B; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-88246676008so27555046d6.3
        for <cgroups@vger.kernel.org>; Fri, 14 Nov 2025 12:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763151975; x=1763756775; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UBXKy1JsF+c00Tx+eyE82c66VPELlnaIipoBvhQAyvw=;
        b=TiYFqd0BTt2mZ6srySit3jk/+X3wivp7VK8J2GXtR7R4t99gMypfMjgmMiK12L3IbU
         7Wh+uEeYR3kO7LyS+OXrdfUS3YTG9HzOmn188gUQtavkC8CRFIoXdQg/7r+JF8oh5Pk3
         nwYNhxny2jHPd5rt4A21vGOI5lLzUf8noHwPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763151975; x=1763756775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UBXKy1JsF+c00Tx+eyE82c66VPELlnaIipoBvhQAyvw=;
        b=xNh86oMOYJYNl2SNCoDf543umlqATOEF06m1w+U6JBHvKZeEmCKhUrLveYZohABbPW
         ydB3mIVXI/5E4E0GpU256kLAQnf4K/sEebQErlfmvjkZO8yw8aZPcT36BuH/0Sw0C8W8
         AApOcBuZrpHVlN6vQZBUYtGIYeHDZHCuXhfmRcZ0Vc47ozCxKe79pu8Njcl1GgVDsvo2
         zrYk+gjyCxkWlEhSTvbIS4W6bL07oNB4/Bm4COD/cRnNKb5LgBRpOUnbLONdeapkiaiE
         2fPw7Z3uFVd2tDFb8hKRzJi3wTuTQyPTvI7+TGSv1DvVXk63J141d6StDReekkvYpvgX
         Tytg==
X-Forwarded-Encrypted: i=1; AJvYcCU61/EeXRQ/oQg1nZVALXwYAamVlVPD1Xm4bfSJIFNsEkSKwm0KehTEMcZtvS1MSZfnPWDKJyrF@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2r38vEJYCOYd0DHsVxxzoQn4JyLgKVnqnc40xW2JMG59JapDx
	gyEqgHTeSdi4mXhq7lO0ShnqQbDGa9hs4CH5jmWR+75/UNoo3srZsYkEalX710tOTMZpxLBlZGb
	LrN4=
X-Gm-Gg: ASbGnctcxeeUK4t3StmGqsYaJP7xrr5hXhB1wErZn67rYG8hs2IkMYsPmvXgqDXKdQu
	x48F2XLgL0Sou+ZArEcfaYWyAityr+HNQXhcYVx1nF/LVK8l6j+A/QQS5OGVStBc5Z0NYIIJhrd
	bj+vi2TrxceDOlyXJgZz0PuW2d5M9/Q2Le8R8g5lIxbWMZw8ITxDzTpbwWejmmyairqNSpK1S/Q
	aDbv9x/Yt7gfwrOR770J/sYYcGPXU5dGCMfwngCFwEjHTEvYbfdCpJeqOxmBpwrSFE30gbGLr7v
	ly5gor9b0VrTBquZoffretxkjhMRV6EHrkABCPMNd6TRZTbjwlkUXcrife52ILVCs5zli/Yyta7
	AxTvFElI0ZTbXwHKaObpKrvvmh1zZNJeZ72+Wda1/qylPNC0xAkBSBExopcVMjO+GFgGfTuyljK
	vvSPfsCQgyCwNd1jPgEuupr6Hwr6pgGCaGTS05p+H639+51hMB+yQ=
X-Google-Smtp-Source: AGHT+IGFt0wYY5T9UVoyEGh/0i0QIH6nbdwqV5bMP8VPj9FcFP664XFXCHV5CCMy0R2SnKrG2RZ4cA==
X-Received: by 2002:ad4:5ae4:0:b0:880:23fb:9e63 with SMTP id 6a1803df08f44-882926de3d9mr65462126d6.56.1763151975529;
        Fri, 14 Nov 2025 12:26:15 -0800 (PST)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com. [209.85.160.177])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8828630e991sm38699766d6.15.2025.11.14.12.26.14
        for <cgroups@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Nov 2025 12:26:14 -0800 (PST)
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4ed67a143c5so67691cf.0
        for <cgroups@vger.kernel.org>; Fri, 14 Nov 2025 12:26:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXfwVMWeweU/EL4sBikBw1obv0yMo7OtuiXoebf+MJ3sF6DRG83L4Q7gdYcgYXS1E5+niHUdi3N@vger.kernel.org
X-Received: by 2002:ac8:5893:0:b0:4ed:341a:5499 with SMTP id
 d75a77b69052e-4ee02c20affmr644891cf.11.1763151974060; Fri, 14 Nov 2025
 12:26:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730164832.1468375-1-linux@roeck-us.net> <20250730164832.1468375-2-linux@roeck-us.net>
 <1a1fe348-9ae5-4f3e-be9e-19fa88af513c@kernel.org> <2919c400-9626-4cf7-a889-63ab50e989af@roeck-us.net>
In-Reply-To: <2919c400-9626-4cf7-a889-63ab50e989af@roeck-us.net>
From: Khazhy Kumykov <khazhy@chromium.org>
Date: Fri, 14 Nov 2025 12:26:02 -0800
X-Gmail-Original-Message-ID: <CACGdZYKFxdF5sv3RY19_ZafgwVSy35E0JmUvL-B95CskHUC2Yw@mail.gmail.com>
X-Gm-Features: AWmQ_bnp-FrH81LO9wZI0yv8eE_oTDu_DOH8Z8kJMW2op_FnlMZESx-1cXuPw40
Message-ID: <CACGdZYKFxdF5sv3RY19_ZafgwVSy35E0JmUvL-B95CskHUC2Yw@mail.gmail.com>
Subject: Re: [PATCH 1/2] block/blk-throttle: Fix throttle slice time for SSDs
To: Tejun Heo <tj@kernel.org>
Cc: yukuai@kernel.org, Guenter Roeck <linux@roeck-us.net>, 
	Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>, Yu Kuai <yukuai3@huawei.com>, 
	cgroups@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 30, 2025 at 4:19=E2=80=AFPM Guenter Roeck <linux@roeck-us.net> =
wrote:
>
> On 7/30/25 11:30, Yu Kuai wrote:
> I had combined it because it is another left-over from bf20ab538c81 and
> I don't know if enabling statistics has other side effects. But, sure,
> I can split it out if that is preferred. Let's wait for feedback from
> Jens and/or Tejun; I'll follow their guidance.
>
> Thanks,
> Guenter
>
noticed this one in our carry queue... any further guidance here? If
my opinion counts, since this is a fixup for a "remove feature X"
commit... I would have done it in one commit as well :)

