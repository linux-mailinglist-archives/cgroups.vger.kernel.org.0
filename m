Return-Path: <cgroups+bounces-816-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84429805AF8
	for <lists+cgroups@lfdr.de>; Tue,  5 Dec 2023 18:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F89B28141C
	for <lists+cgroups@lfdr.de>; Tue,  5 Dec 2023 17:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF791692AF;
	Tue,  5 Dec 2023 17:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QbjHyCdi"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36E221A4;
	Tue,  5 Dec 2023 09:15:50 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-5c66b093b86so2335285a12.0;
        Tue, 05 Dec 2023 09:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701796549; x=1702401349; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HPp8UMYCoK8OfqAUwejxJ+kPtnbv2SL+QsIRvEkjCew=;
        b=QbjHyCdifNEaHnI0f54JdByHJVJGTeopHzp/PSZ0DY/ReKxnh9Whn+9PtEOtnaF4z1
         YI3mEu2j+nhNZHmRnlyjySlw+7vBGO3e7up9AL+aA/GQHs3GKxRtaz7jdmXJjFcnGKCf
         daAMVsn27J32bnHurVBuHABK7JWp5c6oMwsGaZTmpcI01cwLZImI+oEhSPHn2WCVJMLj
         waJfTea2GVj9LvC5Ur2n4Xd+Z8/n6zIEHN623wPixiAC19+HTC2RtylGZIAAkjvDPMKk
         zfBWb712gwsU/2SvYxxDk6wmMKEiAsosSSKoH3blolMpHhrgxT7QX1ianBfeK538NaCD
         ElSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701796549; x=1702401349;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HPp8UMYCoK8OfqAUwejxJ+kPtnbv2SL+QsIRvEkjCew=;
        b=voRgE1g8CGs/aikOmnFVL+pYGghbZsVr11NRwA9gZghhevP5FjhOf2cKL/lgazpDK+
         wav7Ok3DTP1ElGLMShf1v2W/b5FpJPF88spuUxmR6II5/3WjmQ3/wLHpatVTjrxf95JU
         YbkwYN/flgCFOKu2ZVuB1r+xU/hBPTjV1Bnpme7F4YKw1SJDfl5QfbY3FvE+MYzvHPlg
         pGYWM8LBscf8rRdfoS4+9YRBcpSRdjHxUcjDwdNFnU3wfyMu4xWYoCV7Ne7wyRmX4wAl
         bzZPhWUqHQYXURN29PDh9Oa7S2i4vemEPKXvRaBIdLZTUXUKpCkxxInKK2mRmnF1Jdrs
         fCuA==
X-Gm-Message-State: AOJu0YwfKjjC0FFiPI0A/5crma/I60NrWbyg2WZsXiMU4D32eqKNAjYo
	1/bWgul50lziZ0YkLWA+G7g=
X-Google-Smtp-Source: AGHT+IGK8jkOPUjkiVnT9awlbjaR3p1cXJ709zxt2xafAqFrtx6tS4WepQoB2CTTqCKLPfr2A5Cczg==
X-Received: by 2002:a17:90b:1e05:b0:286:fbb0:2cf2 with SMTP id pg5-20020a17090b1e0500b00286fbb02cf2mr254778pjb.20.1701796549474;
        Tue, 05 Dec 2023 09:15:49 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::4:27ef])
        by smtp.gmail.com with ESMTPSA id 13-20020a17090a034d00b0028656e226efsm8811443pjf.1.2023.12.05.09.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 09:15:49 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 5 Dec 2023 07:15:47 -1000
From: Tejun Heo <tj@kernel.org>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
	cgroups@vger.kernel.org
Subject: Re: [RFC PATCH bpf-next 0/3] bpf: Expand bpf_cgrp_storage to support
 cgroup1 non-attach case
Message-ID: <ZW9aw52vXIQTgq9A@slm.duckdns.org>
References: <20231205143725.4224-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205143725.4224-1-laoar.shao@gmail.com>

On Tue, Dec 05, 2023 at 02:37:22PM +0000, Yafang Shao wrote:
> In the current cgroup1 environment, associating operations between a cgroup
> and applications in a BPF program requires storing a mapping of cgroup_id
> to application either in a hash map or maintaining it in userspace.
> However, by enabling bpf_cgrp_storage for cgroup1, it becomes possible to
> conveniently store application-specific information in cgroup-local storage
> and utilize it within BPF programs. Furthermore, enabling this feature for
> cgroup1 involves minor modifications for the non-attach case, streamlining
> the process.
> 
> However, when it comes to enabling this functionality for the cgroup1
> attach case, it presents challenges. Therefore, the decision is to focus on
> enabling it solely for the cgroup1 non-attach case at present. If
> attempting to attach to a cgroup1 fd, the operation will simply fail with
> the error code -EBADF.
> 
> Yafang Shao (3):
>   bpf: Enable bpf_cgrp_storage for cgroup1 non-attach case
>   selftests/bpf: Add a new cgroup helper open_classid()
>   selftests/bpf: Add selftests for cgroup1 local storage

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

