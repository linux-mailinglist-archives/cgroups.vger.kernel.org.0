Return-Path: <cgroups+bounces-10883-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D746BECC08
	for <lists+cgroups@lfdr.de>; Sat, 18 Oct 2025 11:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBB45585257
	for <lists+cgroups@lfdr.de>; Sat, 18 Oct 2025 09:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81A828C5B1;
	Sat, 18 Oct 2025 09:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PfQLKspQ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DB819DF9A
	for <cgroups@vger.kernel.org>; Sat, 18 Oct 2025 09:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760778145; cv=none; b=OHMQjBKKv4t2qoD9zaH2vXfYvknMLMWjpCchNeuvjegNm99n1W7P9LieqI6eU0dGhVfcf3XniioFBdu65Y4V1XY+gtZHEjmDR9s+L2E5ullpsCFbagNthGQ4OHPSrvWURnVCr6sgMPCVFNzcQUX3a9MGCIH/PAS6PcrCkrFZ9D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760778145; c=relaxed/simple;
	bh=lHKi5i/sJex58mREWHcHsQF4zHU2cLpBkKVl4FDsogQ=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=e5crP8CRKEzerfosLM8kHDXGo9O95jrgVjnv6ZmUdyBjFctD3bsJr7jVnlQvyhNZtUQlApar7mKVnp/OT2lFQBZ4iJfF7GAS4CPKWu7QmxSZ/qNFa5f5HQ6bjUm61sg34KGC9U6pGZv7eAvJrELTgIhx2UYfhucnW02VSU49y6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PfQLKspQ; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-426fd62bfeaso1188148f8f.2
        for <cgroups@vger.kernel.org>; Sat, 18 Oct 2025 02:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760778141; x=1761382941; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:content-language
         :to:user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=idTh/zZ2V3DvTTHemfTAHLGIAboJPZQOhr+fyswyWuk=;
        b=PfQLKspQdBA6J+MFVKumYTj9gDdgtT6SlXzY6hA/fzkeZ8X0ztzFK7gC26vNIMEoSZ
         Ws8jUMpEL9j8JwrEm/49/9bGljf5+o4sFSc/6T7jR6RTFavrgpTXIqCM03tHjdohuQkY
         Kt0Gfs1G2y7eDr25dxYzkShHWpsjR50Bc8lPyzE4AYDQI+P0nqgrzks2YOjZzbgMhHsJ
         +5wNTLBu+ZvtYDn6hdsYOX3gILFMfon+EJ5I+QQ+QVVekss5BS4IFV0c+rLI2P0Acyw4
         qqBvWwIeFH12xuJq4trQF6IigES9ys9i+PhIsuNVx7inds99TFYYY8ZmgWFzZghCLrwj
         5Jrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760778141; x=1761382941;
        h=content-transfer-encoding:autocrypt:subject:from:content-language
         :to:user-agent:mime-version:date:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=idTh/zZ2V3DvTTHemfTAHLGIAboJPZQOhr+fyswyWuk=;
        b=TaYuOv8BZ6865Pu+qhvUtUjbT3WeqYGCKKXqC0nPN2LtMvkoOR4oBvfSG4ctni3AaO
         LIubSTp/FZRsnjfPvdbBQxCVyFuWtMH74NEnTel0zM2WmoY82yXkMXE3oCEJfV5OQax4
         OdWuKMxSeoW83RZlamba5hGHTcUVZHPyq2p2cc6VF3AnTcIxYglyIXTZ3DA6XrNnGbni
         d50rEHPEEBzXJENziNp3OJkLxoEIQFeNnJgYQKqt+BlSIIew+fYVm8hHh/ZeoKX7dl3w
         QJNChw8I7l0DN58xr53xWqFDl5Fr2Qmq3hhHlOcs9a5t1ijFTcS76OClLKwMuubeT8+h
         RUlw==
X-Gm-Message-State: AOJu0YyKyPCgXHzUicvii1iyDzG0Lwzxck7LWPUsfEJ6GvXD3Jp6wC3e
	TcwAuW0SNiRhw9rrB+OWekmxzeBk30A3gGdWKoj/11m1Oa1B9BZMi5WE5rRVW/p7YclHaPoe+Ss
	ZDpEu
X-Gm-Gg: ASbGncvf3zw1Zcj/6kyEw0kf2RhgnPNChWvq8p+wMaHg0Sr9owDCoswYNCFbglerPcb
	szi/cnAhFafyD+9jQeclKNQP2jAKxeaMMQ5aU4C4Mf1t7PmxWRaFJnmBIrfi+JWHsBNdbj3C01F
	nYD+Ti9Mw/5fdsdUZC+EYo5Tl/LQvm9mx5hFVz0OXXYfcRUKTBKzJgnkgqyBP5v2mdZsoejGBDf
	t2lzF0XsR73nAvhyH1eMVLjlcrv5prfYnFL9SxV+E+9w/Y/7lFoUna0jKeUabILdB7fKNP1BY6L
	m2yru4wljUWUENmRGZiZO+a2v56gtgeHfDGFKzW1TJBmA1loMQC8WKok6dRy0k5mMJwQAFZKAC8
	+psFiNN6rllqaqHKh4UB1UHCheYXAAqW/UsOPv8YT7Vln5OMMxUNYzLSrGfzPd7IVVOXrKkFT+w
	HFkFXSG9gWdqjKYDqtpS4waGdxvuFV+XC+cgosDNI=
X-Google-Smtp-Source: AGHT+IFtLhqYFBMVJJD1XokMA7KMKE5OPSBdpXI1OPteUViD3kLeCT960qipemHibBHEDTol+ZFhLg==
X-Received: by 2002:a05:6000:400a:b0:427:2e8:fe3a with SMTP id ffacd0b85a97d-42704d14689mr4672336f8f.13.1760778141274;
        Sat, 18 Oct 2025 02:02:21 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2924721b6fdsm19624295ad.118.2025.10.18.02.02.18
        for <cgroups@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Oct 2025 02:02:20 -0700 (PDT)
Message-ID: <d41dff2c-71e5-4ea3-b7d5-8412b5b0b3e6@suse.com>
Date: Sat, 18 Oct 2025 19:32:16 +1030
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cgroups@vger.kernel.org
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Subject: freezing() returned false when the cgroup is being frozen
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXVgBQkQ/lqxAAoJEMI9kfOh
 Jf6o+jIH/2KhFmyOw4XWAYbnnijuYqb/obGae8HhcJO2KIGcxbsinK+KQFTSZnkFxnbsQ+VY
 fvtWBHGt8WfHcNmfjdejmy9si2jyy8smQV2jiB60a8iqQXGmsrkuR+AM2V360oEbMF3gVvim
 2VSX2IiW9KERuhifjseNV1HLk0SHw5NnXiWh1THTqtvFFY+CwnLN2GqiMaSLF6gATW05/sEd
 V17MdI1z4+WSk7D57FlLjp50F3ow2WJtXwG8yG8d6S40dytZpH9iFuk12Sbg7lrtQxPPOIEU
 rpmZLfCNJJoZj603613w/M8EiZw6MohzikTWcFc55RLYJPBWQ+9puZtx1DopW2jOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXWBBQkQ/lrSAAoJEMI9kfOhJf6o
 cakH+QHwDszsoYvmrNq36MFGgvAHRjdlrHRBa4A1V1kzd4kOUokongcrOOgHY9yfglcvZqlJ
 qfa4l+1oxs1BvCi29psteQTtw+memmcGruKi+YHD7793zNCMtAtYidDmQ2pWaLfqSaryjlzR
 /3tBWMyvIeWZKURnZbBzWRREB7iWxEbZ014B3gICqZPDRwwitHpH8Om3eZr7ygZck6bBa4MU
 o1XgbZcspyCGqu1xF/bMAY2iCDcq6ULKQceuKkbeQ8qxvt9hVxJC2W3lHq8dlK1pkHPDg9wO
 JoAXek8MF37R8gpLoGWl41FIUb3hFiu3zhDDvslYM4BmzI18QgQTQnotJH8=
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Recently I'm fixing a bug that a long running btrfs ioctl can prevent 
suspension and cgroup freezing.

The root cause is btrfs lacks the proper checks to abort the ioctl, so 
that the process can return to user space.

The fix is not that hard, normally some freezing() checks.

But I noticed that in the ioctl context, if the pm triggered freezing, 
then freezing(current) properly returned true.

However if a cgroup freezing is triggered for the process running the 
btrfs ioctl, freezing(current) will still return false.

The pm code has dedicated booleans, thus when pm is involved it 
freezing_slow_path() just checks @pm_nosig_freezing and @pm_freezing 
flags driectly.


On the hand for cgroup freezing case, it has to go cgroup_freezing() to 
check if the cgroup is freezing.

Not familiar with cgroup, but it looks like the CGROUP_FREEZING bits are 
only set during freezer_css_online(), but not sure if for the long 
running ioctl case it's properly triggered.


Anyway the freezing() checks can be worked around by checking pending 
signals inside btrfs, as cgroup freezing will send a wakeup signal to 
the process.

Just curious if the freezing(current) is supposed to return false for 
the cgroup freezing case.

Thanks,
Qu

