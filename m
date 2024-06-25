Return-Path: <cgroups+bounces-3370-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E15691750A
	for <lists+cgroups@lfdr.de>; Wed, 26 Jun 2024 01:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 051D32814FD
	for <lists+cgroups@lfdr.de>; Tue, 25 Jun 2024 23:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A6117F500;
	Tue, 25 Jun 2024 23:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=discourse.org header.i=@discourse.org header.b="mJVaM5KZ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D970A17F4F7
	for <cgroups@vger.kernel.org>; Tue, 25 Jun 2024 23:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719359641; cv=none; b=YCswLN7//t3aiVoqSRpD+iiPk3ZFKgjMFYOSygFethyH5Z75AfwLxb6dZTsNGtixgQTEoKeLiNWT0nQmJesUhezdk+J7XiSvVfTb2nKShX4VAH6TMkZwrlXfKLaMolOq3PVbVSMz4VjLZnsSblbF8anZ9oPzAkZz7XyqO3xqAv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719359641; c=relaxed/simple;
	bh=pQNZEZNwz1ioAj1KNHjnnLsx6FDY5JVOhHdzQxs3nS8=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=eGBUz/7hBvhQzYlL91b+BxK7fIZx6S613ZEPlXDo0LRhXOnSvDmmO2kTxrn+NU5shz1ntBKwVMQsji5F0oh5KQ7Ng1LDETv/X576oqp01TBXjsBfaeE/WXZy5C8EpwALM/ehW7ZyEFvvNHJtWqfrEiK7K+RcDIMMy68WJc0Fu6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=discourse.org; spf=pass smtp.mailfrom=discourse.org; dkim=pass (1024-bit key) header.d=discourse.org header.i=@discourse.org header.b=mJVaM5KZ; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=discourse.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=discourse.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7066c799382so3571961b3a.3
        for <cgroups@vger.kernel.org>; Tue, 25 Jun 2024 16:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=discourse.org; s=google; t=1719359639; x=1719964439; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:subject:from
         :content-language:to:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YacuGbOZeNDuZ75jlSABPBVEs2f8uiAjwyGONERGYVA=;
        b=mJVaM5KZVnz+UN844VTPHleZAeVtrj97Smyy0avTi8g+raPkgk65wtbgF+4bRq3n0E
         0Jhzy2sNWiuFWIJkyOQn6IFMKMIQeFoFDWMKnUZvrT577IESUTB/scahxZKUQStcBc64
         D1Z9Nij0MqT7nvk3Q/O7/WOrrMMlXYSVozyY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719359639; x=1719964439;
        h=content-transfer-encoding:organization:subject:from
         :content-language:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YacuGbOZeNDuZ75jlSABPBVEs2f8uiAjwyGONERGYVA=;
        b=RFcHz80+i9UHNTLbbFgtAgCF67bVTS0tz9HlxDEJGcS77hEzhNuO2qz1lxlgdvIKxf
         7VJrNHL0mXk2V1dV/haGCMgfm8O8AHHVEfgAiq21gRZrj5Sqjo980Htnq6+pjjVp3EXc
         SP/xn1gGl5IhEdF6KncdFDSxLEPhEjrBw2SyClE/ReBPNFVcbUwQc4/Vcgj//TWbBYJ3
         w7QnPx292btabO3xOxfGIOicp7c8flx0hW97UNuW1sdEtNhwAsH+YW6xFaEMrpkqE+W9
         YUlllSZV0rN/juOpARg7m8UsYOJQlyqn65Mc+rpUdN+eb4n2jGZ2PcNHMLAoieLQgb2i
         7ChQ==
X-Gm-Message-State: AOJu0YzxkhbxRjwLvo498TAqznG0kCZndVZly01/WY2GGJkimWU6crKr
	KmFphHZahl7WTdsTxvRc+FAAi8MuhRrSnTn8AxwT33uq0bwOSJozGHW6/bkadw9NS5WFSI9R2ew
	PAcEsBBm2rep75Rwfc7K+KIoc+IpPHd6kVktooLX1MlrKDnK36PXWGXVXK5Efj/QmEmpBJ0GBBg
	91dZft50RAzXBWla5mqh6ujzMDg73CVF+eh0jGcQ==
X-Google-Smtp-Source: AGHT+IHAfUKeUGy31a/X8AjB5oyh8L8K/AtZriuY5p0IUvuKsDub6bROxaPQGvUYwRH7OKLhVYtBAg==
X-Received: by 2002:a05:6a21:789c:b0:1b6:3dfa:cc09 with SMTP id adf61e73a8af0-1bcf7efc84cmr11105502637.35.1719359638504;
        Tue, 25 Jun 2024 16:53:58 -0700 (PDT)
Received: from ?IPV6:2403:5817:22f2:0:2ef0:5dff:fe39:5b3a? ([2403:5817:22f2:0:2ef0:5dff:fe39:5b3a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-706a7aab875sm148221b3a.103.2024.06.25.16.53.57
        for <cgroups@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jun 2024 16:53:58 -0700 (PDT)
Message-ID: <d13273c1-533b-46b4-a3ab-25927a8b334e@discourse.org>
Date: Wed, 26 Jun 2024 09:53:55 +1000
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cgroups@vger.kernel.org
Content-Language: en-AU
From: Michael Fitz-Payne <fitzy@discourse.org>
Subject: unexpected CPU pressure measurements when applying cpu.max control
Organization: Civilized Discourse Construction Kit, Inc.
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi there,

We've observed some unexpected CPU pressure measurements via the 
/proc/pressure/cpu interface when applying the cpu.max control within a 
cgroup.

In short, processes executing within a CPU-limited cgroup are 
contributing to the system-wide CPU pressure measurement. This results 
in misleading data that points toward system CPU contention, when no 
system-wide contention exists.


For example: we create a cgroup limited to a single CPU (cpu.max = 
'100000 100000') and within that cgroup we launch 10 processes vying 
over that CPU.

I'm using systemd-run in the command below for convenience sake, where 
the CPUQuota property sets the underlying cpu.max cgroup control.

The command that launches the 10 processes is `stress --cpu 10`.

[fitzy@~]$ uname -r
6.8.9-300.fc40.x86_64

Execute the process:

[fitzy@~]$ sudo systemd-run --property CPUQuota=100% --slice example 
stress --cpu 10
Running as unit: run-rf1c808a9ce1d4e7c82cc57ab90e728e3.service; 
invocation ID: 67b0808e72364325940cfa898231e83e

Observe the cgroup-specific CPU pressure measurement:

[fitzy@~]$ cat 
/sys/fs/cgroup/example.slice/run-rf1c808a9ce1d4e7c82cc57ab90e728e3.service/cpu.pressure
some avg10=87.32 avg60=86.44 avg300=56.96 total=272053462
full avg10=87.32 avg60=86.44 avg300=56.96 total=272053075

Compare to the system.slice CPU pressure measurement:

[fitzy@~]$ cat /sys/fs/cgroup/system.slice/cpu.pressure
some avg10=0.00 avg60=0.00 avg300=1.89 total=333141519
full avg10=0.00 avg60=0.00 avg300=1.89 total=332415623

Compare to the system-wide CPU pressure measurement:

[fitzy@~]$ cat /proc/pressure/cpu
some avg10=85.37 avg60=84.94 avg300=65.05 total=1655875251
full avg10=0.00 avg60=0.00 avg300=0.00 total=0


I've compared these tests on a 5.10.0 system as well as 6.8.9 (above).

There are two differences I can see:

- On 5.10 the 'full' line is not present in either the cgroup 
cpu.pressure interface or the kernel /proc/pressure/cpu interface. I'm 
assuming this was added in a newer kernel at some point.

- On 6.8.9 the 'full' line in the cgroup cpu.pressure interface appears 
to provide accurate data based on this simple test.

As we know, the kernel 'full' measurement is undefined.


In either case, the kernel PSI interface is the canonical source from 
which we want to read the measurements for warning us of CPU contention 
on our fleet of machines. Due to this unexpected accounting, the values 
may be misleading.

Frankly, I'm not sure of what the behaviour should be. I can see the 
argument that the current value is correct, given the definition is 
'some' tasks are waiting on CPU.

However we have no data to fall back on - we cannot use the 'full' 
measurement from the kernel for CPU pressure. Unless we segregate all 
CPU-limited processes into their own cgroup slice and read distinct 
measurements from there, we also cannot rely on reading the cgroup(s) 
cpu.pressure interface.

For now, we are preferring the use of CPU weight controls - which only 
come into effect at saturation points - as a compromise. This isn't 
always the preferred control, because we sometimes want to place a hard 
cap on cpu-hungry but low-prio processes (e.g. log transformation services).

Does anyone have advice, or can comment on what the expected behaviour 
is under these circumstances? Perhaps this is simply WAI, and we need to 
make concessions higher up in the stack.

fitzy

---

Michael Fitz-Payne
System Administrator
Civilized Discourse Construction Kit, Inc.


