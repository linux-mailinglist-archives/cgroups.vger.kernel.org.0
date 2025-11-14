Return-Path: <cgroups+bounces-11952-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B28C5BB04
	for <lists+cgroups@lfdr.de>; Fri, 14 Nov 2025 08:10:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5C9314F1AF2
	for <lists+cgroups@lfdr.de>; Fri, 14 Nov 2025 07:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2F1296BA9;
	Fri, 14 Nov 2025 07:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dP3Yqg5Y"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1E41FF7C7
	for <cgroups@vger.kernel.org>; Fri, 14 Nov 2025 07:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763103910; cv=none; b=AiLgnZnAdcPyzFSuE9ulO3PZ6PvqFlniVbE0Zf3BdYciDrZTpRizwayRimk1VNh0jrJhDgjS7OMyuF0v10lWE8GnxYhrYa9SdWLp2ikx6gGGSl3BqqaX8cG8mOn+vKDazrtU3kjwV3zWEyDYgdL5jvJAIjDLTtB/CUOMQ6MJFik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763103910; c=relaxed/simple;
	bh=81bB82ka39OClX8Q0o7YIpWuPMYAslJbQmnQB3rWa5M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=avETvWq8pOwPfSPS7UF1w59eB7j2oySWSKKMAlKVs/iWyfEvHZtGYNPsw+P1KJ49aZi3lGP9oMo72HlkGNNbwoBDSgdKWSagSRc4ZW82T3WG9Ygo/yqc4OOP7d7DqTKfXLNJtvaDNBexJq7Q026wCyjP/QW/RdFyAYl+Ucbpgl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dP3Yqg5Y; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-429c7869704so1254333f8f.2
        for <cgroups@vger.kernel.org>; Thu, 13 Nov 2025 23:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763103906; x=1763708706; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=81bB82ka39OClX8Q0o7YIpWuPMYAslJbQmnQB3rWa5M=;
        b=dP3Yqg5YRz1v1Q8aouFcErFcfhiPzfUM9JGkna4dxwoB3xjXjDJyCwwW+lxNIa1XLB
         LbCSDAiYpv6q+oVSAiesQRMyBUgNRd2WrRNstFu2FnccM5TR+n5LklOjVEdAfiflWmcX
         nkZ+2IZVSwd3anq1ELSkQ1FcJPPxq/jLBNdF89KyvevG5m8TBpRWXtG5KYi9wbJ679VK
         qwpVdnJrQPY6DwAC//ltZneIYyMTa1kFY3ZwKvI7v1gj7XtQQsGK4g2LKuynhHkKTbhY
         Rqi3Tz2okA7lWpvJdtB1mw7XTNAgLmDFAa0YeT1uB2NfzKOjdHaH8yTb+eiA14xQ1UMm
         Jmlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763103906; x=1763708706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=81bB82ka39OClX8Q0o7YIpWuPMYAslJbQmnQB3rWa5M=;
        b=kH0O8jbiLzOwv8IQyie5H/jXOXL39fAqTZV11XIgDN+wksZc0JW/v50KY++PZotNkS
         7P+tMSTnZ7YGv+WsjLEYypph6c/WERivegU2jVto/qBmbE0HrNu3+XXgDw9I6vKWySSs
         h2tcpGTd1/vaG4ZuhUsTsdlweDfyGENOCvFLKIltWsJjGlwEs3EcucSR9VlD2x/VB94X
         KE8pP3Lj95BKv7xWIjCHmZ5tBNLxqwI/KCY+1sjW+7BKNe5OiyryD1BHspKlp5zLrj6V
         EqnYOxM93hZOxo4H3uO0nRwyIkB0RfVRt86nBG/MjeHOryENrHPOnnwRvQIRbwbN+4kp
         e5HQ==
X-Forwarded-Encrypted: i=1; AJvYcCV74RC4jyditFdq5W8OoeOrTvz1AFKYcG3NPi0Hvf+/Gx35BFqTFHGSd3ue5hhP9VdaTneoUUBo@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9G/vyLfbkBsltwo690t20sg2LepwoQlcNtc2b4oVZjlkNiOR7
	CmSf4YuAYPhPMxLHwxiN0ouIlfZB5o3M+/hB74Bu0Syctb1WFuByMeRZ8q/i2LusAr6X2zsp4Uj
	Wp7//a7TOF3bnD5wwctto854WoMoBpaZPv4Jh9Eqx4Q==
X-Gm-Gg: ASbGnctiWRiNmWMvI2rNa2pip9vvAnYrZS89uChvwGYRw0n9meOpvOIbmcBK1i6eA+y
	APvfnyazW+M93mbYtrp2WlyxmqNsLJa+ofC+yMj/1uqQ1J9wX2Et9te53z6GWuGDlIhEnas0U5G
	lJV9drhzvasDzedUjkIJV75pmGlkqkkofKHOpBlzWsxf0KdtJOg26DpvUlAZxOkm6F1StkT18kd
	WUMnbRDwP7+4l/kWOsEH/PtUI6wGBuBdLe41wUf3kXVtOu/5k5zvGS93Q==
X-Google-Smtp-Source: AGHT+IHZPORBx9Z6NEea2uQhhOChitNrQVS3plNh/xzXa5rtn5vFShG3ygCnLg/SG7mPe+IIGXme7azCutvRlaEIaSU=
X-Received: by 2002:a05:6000:4024:b0:42b:40b5:e683 with SMTP id
 ffacd0b85a97d-42b59349a6amr1680035f8f.23.1763103906496; Thu, 13 Nov 2025
 23:05:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6lwnagu63xzanum2xx6vkm2qe4oh74fteqeymmkqxyjbovcce6@3jekdivdr7yf> <6916a904.9d0a0220.2b5e5.0b79SMTPIN_ADDED_BROKEN@mx.google.com>
In-Reply-To: <6916a904.9d0a0220.2b5e5.0b79SMTPIN_ADDED_BROKEN@mx.google.com>
From: Sebastian Chlad <sebastian.chlad@suse.com>
Date: Fri, 14 Nov 2025 08:04:55 +0100
X-Gm-Features: AWmQ_bnKudVmCNylFi9hMvxUWZfrXa2eW_i6kp-gT9MEkjJisOwKPDQZu5R1KgE
Message-ID: <CAJR+Y9LG+qrvDdbufNpBqW4+8oPBrmY3eABJzXBm9Y_DPN4XLg@mail.gmail.com>
Subject: Re: [PATCH] selftests/cgroup: conform test to TAP format output
To: Guopeng Zhang <zhangguopeng@kylinos.cn>
Cc: mkoutny@suse.com, tj@kernel.org, hannes@cmpxchg.org, shuah@kernel.org, 
	cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 4:59=E2=80=AFAM Guopeng Zhang <zhangguopeng@kylinos=
.cn> wrote:
>
> Hi Michal,
>
> Thanks for reviewing and pointing out [1].
>
> > Could you please explain more why is the TAP layout beneficial?
> > (I understand selftest are for oneself, i.e. human readable only by def=
ault.)
>
> Actually, selftests are no longer just something for developers to view l=
ocally; they are now extensively
> run in CI and stable branch regression testing. Using a standardized layo=
ut means that general test runners
> and CI systems can parse the cgroup test results without any special hand=
ling.

I second that.
In fact, we do run some of those tests in the CI; i.e.
https://openqa.opensuse.org/tests/5453031#external
We added this: https://github.com/os-autoinst/openQA/blob/master/lib/OpenQA=
/Parser/Format/KTAP.pm
to our CI
but frankly the use of the KTAP across the selftests is very
inconsistent, so we need to post-process some of the output files
quite a lot.
Therefore the more standardized the output, the better for any CI.

Small ask: should we amend the commit message to say KTAP?

That being said - the cgroups tests produce nice output which is easy
to parse and gives us no issues in our CI apart
from the shell tests, specifically test_cpuset_prs.sh.

We currently run the cgroup tests only internally because some of them
tend to fail when crossing resource-usage
boundaries and don=E2=80=99t provide clear information about by how much.
That ties into my earlier effort Michal linked here::
https://lore.kernel.org/all/rua6ubri67gh3b7atarbm5mggqgjyh6646mzkry2n2547jn=
e4s@wvvpr3esi5es/

I=E2=80=99ll try to add the cgroup tests to the public openSUSE CI and will
test your patches.

>
> TAP provides a structured format that is both human-readable and machine-=
readable. The plan/result lines are parsed by tools,
> while the diagnostic lines can still contain human-readable debug informa=
tion. Over time, other selftest suites (such as mm, KVM, mptcp, etc.)
> have also been converted to TAP-style output, so this change just brings =
the cgroup tests in line with that broader direction.
>
> > Or is this part of some tree-wide effort?
>
> This patch is not part of a formal, tree-wide conversion series I am runn=
ing; it is an incremental step to align the
> cgroup C tests with the existing TAP usage. I started here because these =
tests already use ksft_test_result_*() and
> only require minor changes to generate proper TAP output.
>
> > I'm asking to better asses whether also the scripts listed in
> > Makefile:TEST_PROGS should be converted too.
>
> I agree that having them produce TAP output would benefit tooling and CI.=
 I did not want to mix
> that into this change, but if you and other maintainers think this direct=
ion is reasonable,
> I would be happy to follow up and convert the cgroup shell tests to TAP a=
s well.
>
> Thanks again for your review.
>
> Best regards,
> Guopeng
>
>

