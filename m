Return-Path: <cgroups+bounces-2281-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A29B895B97
	for <lists+cgroups@lfdr.de>; Tue,  2 Apr 2024 20:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D08DA286B9E
	for <lists+cgroups@lfdr.de>; Tue,  2 Apr 2024 18:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A89A15AD8B;
	Tue,  2 Apr 2024 18:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A8oglQ0A"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4117515A48E;
	Tue,  2 Apr 2024 18:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712082032; cv=none; b=OsayD2dR/z3GFjVm76mZcON9mPgOequJR3I9aLfXZUn4w2buUoc3VoIIsj/ijumlJLKg+psa6X7dlNAl/Dj2mxn4gTGWrrdox3oGLgeQpUps4ay2qUX2qWEUhL5+yHtnHa739TXjLFeHCaxYSLWR9i9JeQ7IssFRJzkmIRCEj0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712082032; c=relaxed/simple;
	bh=0nIg5V68eFs+S6WZrMtxSDt8j15LDM7MC/w7XzQq4aM=;
	h=Content-Type:To:Cc:Subject:References:Date:MIME-Version:From:
	 Message-ID:In-Reply-To; b=EEMsB5+G4nAgYSzUK0QHJUhNCJO2lvzUG8QSaEkKbJVga35+zNkcB4C9autjrVtQpOdUojMK/B+zOnwC8xy1oDEe0HK+d19D0P1DkSFRS4zL2VPU9uM8YfC6BQV+sAa/M7HEWi/oX02dYgjE1i5HJpW3lUt5YFpGUi36ycsQuRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A8oglQ0A; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712082031; x=1743618031;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=0nIg5V68eFs+S6WZrMtxSDt8j15LDM7MC/w7XzQq4aM=;
  b=A8oglQ0AfVBU8AatD6XT9M+b5UhjQwhN2rtD5cbPmcxFQcR9QTQYshfG
   gt+0AbeVlNuBE4JtjXqBj27h+G9u5kWPArt8K6T6VlzFR/DFtsXvraGJ5
   odRx47Vis90/txE1pE9Xf7Y6sCR4djyvgMuEOxHIxGo6kHSOqAWr6uXev
   SXBJGLGa9+8Hrih6i7x/GVRB/Lhos7Xn1qpkMiLRUqhZUDD9vj4OkUeje
   RaZV/j6gZa+rcQqeTNgubMpU6FSu9+2XRsrtb/uQZsOC7O+SCh5vP8uqE
   b6iu/sAxaOU7UU3kf5bsULs7gev53y74jJ7nGFV9srAXfRncIZt5eQpKJ
   Q==;
X-CSE-ConnectionGUID: JlFDas+gQrqksCjGLq7cUA==
X-CSE-MsgGUID: WAFdYvq8TJuVtR3D8/JGCw==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="24729989"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="24729989"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 11:20:30 -0700
X-CSE-ConnectionGUID: W2CB/e5+SoCTGl3jQ/a3rQ==
X-CSE-MsgGUID: ZBrlNf3NSnaBEgUH3+z5kQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="18133002"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.17.168])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/AES256-SHA; 02 Apr 2024 11:20:28 -0700
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To: =?iso-8859-15?Q?Michal_Koutn=FD?= <mkoutny@suse.com>
Cc: "Jarkko Sakkinen" <jarkko@kernel.org>, dave.hansen@linux.intel.com,
 tj@kernel.org, linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
 x86@kernel.org, cgroups@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, hpa@zytor.com, sohil.mehta@intel.com,
 tim.c.chen@linux.intel.com, zhiquan1.li@intel.com, kristen@linux.intel.com,
 seanjc@google.com, zhanb@microsoft.com, anakrish@microsoft.com,
 mikko.ylinen@linux.intel.com, yangjie@microsoft.com, chrisyan@microsoft.com
Subject: Re: Re: [PATCH v9 15/15] selftests/sgx: Add scripts for EPC cgroup
 testing
References: <20240205210638.157741-1-haitao.huang@linux.intel.com>
 <20240205210638.157741-16-haitao.huang@linux.intel.com>
 <4be7b291010973c203ed8c7bcd25b626c1290231.camel@kernel.org>
 <D04OVW6I8MUA.1OAIHFQ8943SM@kernel.org>
 <op.2lbjl0oawjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <D071OAFZ80O6.XEDXJ8AF4PK9@kernel.org> <D071QIHLW7MP.UM9R3VYETIOK@kernel.org>
 <htiz5jgsby5v262saphhomcsxtixb2u7ot6jcghpfhvgz65ht6@qlz3gpdwapaa>
 <D09MB26IPFFW.3UBD7M0S17SG6@kernel.org>
 <op.2llzn7wgwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <yjremy4leipriqfd547wvjd6jt3r6t4tgz36eazy3slfuew4mc@v4iye7sm7yqn>
Date: Tue, 02 Apr 2024 13:20:25 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: Quoted-Printable
From: "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2ll48bk4wjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <yjremy4leipriqfd547wvjd6jt3r6t4tgz36eazy3slfuew4mc@v4iye7sm7yqn>
User-Agent: Opera Mail/1.0 (Win32)

On Tue, 02 Apr 2024 12:40:03 -0500, Michal Koutn=FD <mkoutny@suse.com> w=
rote:

> On Tue, Apr 02, 2024 at 11:20:21AM -0500, Haitao Huang  =

> <haitao.huang@linux.intel.com> wrote:
>> Do we really want to have it implemented in c?
>
> I only pointed to the available C boilerplate.
>
>> There are much fewer lines of
>> code in shell scripts. Note we are not really testing basic cgroup  =

>> stuff.
>> All we needed were creating/deleting cgroups and set limits which I  =

>> think
>> have been demonstrated feasible in the ash scripts now.
>
> I assume you refer to
> Message-Id: <20240331174442.51019-1-haitao.huang@linux.intel.com>
> right?
>
> Could it be even simpler if you didn't stick to cgtools APIs and v1
> compatibility?
>
> Reducing ash_cgexec.sh to something like
> 	echo 0 >$R/$1/cgroup.procs
> 	shift
> 	exec "$@"
> (with some small builerplate for $R and previous mkdirs)
>
Yes, Thanks for the suggestion.
Haitao

