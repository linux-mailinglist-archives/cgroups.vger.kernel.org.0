Return-Path: <cgroups+bounces-2275-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC55D8959BD
	for <lists+cgroups@lfdr.de>; Tue,  2 Apr 2024 18:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72410B2C4DA
	for <lists+cgroups@lfdr.de>; Tue,  2 Apr 2024 16:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E6814B07C;
	Tue,  2 Apr 2024 16:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sh2FIqYZ"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111D614AD1D;
	Tue,  2 Apr 2024 16:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712074830; cv=none; b=C0OOxB4le9KWFBxD6fa1pglMGwxea2IPXUJsIz8QnW3mrX1aLR3w7VCcXFv9EQd8hxCqI4GxSQMN9Ykz/QeaceFEBaxoR19wUluU6ei0MTPwQWx7c5pegh1c4Pd3vngAlzp5mEO+Xy/F8wk+PjqrwJvndj6G7ofmJu9POxGaklg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712074830; c=relaxed/simple;
	bh=YBovMqze5iU2OuiwBk7yaV5ROH0m1Xil3sSKdX5tHCI=;
	h=Content-Type:To:Cc:Subject:References:Date:MIME-Version:From:
	 Message-ID:In-Reply-To; b=rhE0gv+rxTQpLon6l/i0Uz0l8hbXZd29z30WWgAxB9yicv7t7mGsKXtufNr7CPvQfJqJDqn+dQp6hg6+/tAfbetapIqvWWjO0ZRLda8UthS/0hB8VUrO+CLbEz7NE6JrvGfkUM6tlPN4xaxH9HoWpOGMBbcm9JoH9VIZ2kRQjEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sh2FIqYZ; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712074828; x=1743610828;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=YBovMqze5iU2OuiwBk7yaV5ROH0m1Xil3sSKdX5tHCI=;
  b=Sh2FIqYZoRXzTE9FxUMvYrhQJGq1NUw4zwS9fWWeYug3/rDNPy1y6c/r
   YFEEqe1rVMOi/NzW6b9pR+NVJ/2osVFXfktsaGmAvsB4M1dUle7MlJVit
   Q7nRLUhzml+oP4oGYTCpH0zeBQ7EpB371xTgmgGaKG0NIf558grZHRQ2s
   zayt/83jsU4BXcPBYIPBOIXURboVBxXL27I17+Hx1ljZd9aVhA7Q9kA/c
   4/rwbnfCS70lNXsNgw8d8uCJj5DVUiVk1dA0xOGki6PHYSoOUm/D8Tbq6
   p34uhtBPuGSEvL06jr10M+7TyyQozXAfwv55B/IkPWdyAUpo63paaCrx7
   g==;
X-CSE-ConnectionGUID: zRtNVA8wQiud9WGfKly3sQ==
X-CSE-MsgGUID: yYW49mC8SjqQcwSVOtMN+A==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="17879022"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="17879022"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 09:20:27 -0700
X-CSE-ConnectionGUID: vxxT3scQSXOl1xwOYNfuTQ==
X-CSE-MsgGUID: ldColvJnTb23d8ewg0JsSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="22577715"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.17.168])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/AES256-SHA; 02 Apr 2024 09:20:25 -0700
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To: =?iso-8859-15?Q?Michal_Koutn=FD?= <mkoutny@suse.com>, "Jarkko Sakkinen"
 <jarkko@kernel.org>
Cc: dave.hansen@linux.intel.com, tj@kernel.org, linux-kernel@vger.kernel.org,
 linux-sgx@vger.kernel.org, x86@kernel.org, cgroups@vger.kernel.org,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
 sohil.mehta@intel.com, tim.c.chen@linux.intel.com, zhiquan1.li@intel.com,
 kristen@linux.intel.com, seanjc@google.com, zhanb@microsoft.com,
 anakrish@microsoft.com, mikko.ylinen@linux.intel.com, yangjie@microsoft.com,
 chrisyan@microsoft.com
Subject: Re: [PATCH v9 15/15] selftests/sgx: Add scripts for EPC cgroup
 testing
References: <20240205210638.157741-1-haitao.huang@linux.intel.com>
 <20240205210638.157741-16-haitao.huang@linux.intel.com>
 <4be7b291010973c203ed8c7bcd25b626c1290231.camel@kernel.org>
 <D04OVW6I8MUA.1OAIHFQ8943SM@kernel.org>
 <op.2lbjl0oawjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <D071OAFZ80O6.XEDXJ8AF4PK9@kernel.org> <D071QIHLW7MP.UM9R3VYETIOK@kernel.org>
 <htiz5jgsby5v262saphhomcsxtixb2u7ot6jcghpfhvgz65ht6@qlz3gpdwapaa>
 <D09MB26IPFFW.3UBD7M0S17SG6@kernel.org>
Date: Tue, 02 Apr 2024 11:20:21 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: Quoted-Printable
From: "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2llzn7wgwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <D09MB26IPFFW.3UBD7M0S17SG6@kernel.org>
User-Agent: Opera Mail/1.0 (Win32)

On Tue, 02 Apr 2024 06:58:40 -0500, Jarkko Sakkinen <jarkko@kernel.org> =
 =

wrote:

> On Tue Apr 2, 2024 at 2:23 PM EEST, Michal Koutn=FD wrote:
>> Hello.
>>
>> On Sat, Mar 30, 2024 at 01:26:08PM +0200, Jarkko Sakkinen  =

>> <jarkko@kernel.org> wrote:
>> > > > It'd be more complicated and less readable to do all the stuff =
 =

>> without the
>> > > > cgroup-tools, esp cgexec. I checked dependency, cgroup-tools on=
ly  =

>> depends
>> > > > on libc so I hope this would not cause too much inconvenience.
>> > >
>> > > As per cgroup-tools, please prove this. It makes the job for more=

>> > > complicated *for you* and you are making the job more  complicate=
d
>> > > to every possible person in the planet running any kernel QA.
>> > >
>> > > I weight the latter more than the former. And it is exactly the
>> > > reason why we did custom user space kselftest in the first place.=

>> > > Let's keep the tradition. All I can say is that kselftest is
>> > > unfinished in its current form.
>> > >
>> > > What is "esp cgexec"?
>> >
>> > Also in kselftest we don't drive ultimate simplicity, we drive
>> > efficient CI/QA. By open coding something like subset of
>> > cgroup-tools needed to run the test you also help us later
>> > on to backtrack the kernel changes. With cgroups-tools you
>> > would have to use strace to get the same info.
>>
>> FWIW, see also functions in
>> tools/testing/selftests/cgroup/cgroup_util.{h,c}.
>> They likely cover what you need already -- if the tests are in C.
>>
>> (I admit that stuff in tools/testing/selftests/cgroup/ is best
>> understood with strace.)
>
> Thanks!
>
> My conclusions are that:
>
> 1. We probably cannot move the test part of cgroup test itself
>    given the enclave payload dependency.
> 2. I think it makes sense to still follow the same pattern as
>    other cgroups test and re-use cgroup_util.[ch] functionaltiy.
>
> So yeah I guess we need two test programs instead of one.
>
> Something along the lines:
>
> 1. main.[ch] -> test_sgx.[ch]
> 2. introduce test_sgx_cgroup.c
>
> And test_sgx_cgroup.c would be implement similar test as the shell
> script and would follow the structure of existing cgroups tests.
>
>>
>> HTH,
>> Michal
>
> BR, Jarkko
>
Do we really want to have it implemented in c? There are much fewer line=
s  =

of code in shell scripts. Note we are not really testing basic cgroup  =

stuff. All we needed were creating/deleting cgroups and set limits which=
 I  =

think have been demonstrated feasible in the ash scripts now.

Given Dave's comments, and test scripts being working and cover the case=
s  =

needed IMHO, I don't see much need to move to c code. I can add more cas=
es  =

if needed and fall back a c implementation later  if any case can't be  =

implemented in scripts. How about that?

Haitao

