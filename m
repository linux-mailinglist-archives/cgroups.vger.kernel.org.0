Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC07CA9D8
	for <lists+cgroups@lfdr.de>; Thu,  3 Oct 2019 19:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393188AbfJCRAX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 3 Oct 2019 13:00:23 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35267 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392862AbfJCQp4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 3 Oct 2019 12:45:56 -0400
Received: by mail-qk1-f193.google.com with SMTP id w2so3044902qkf.2;
        Thu, 03 Oct 2019 09:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=cY7dwSAZ/LRC+V3+VuDl/u0CtvPhkHUKtwYdGP4h8tM=;
        b=hLGF2x3mry/9VP8Cgyatm0IMsLfiswwpsqSwtwh3Z2Hay6ZNSrYP6Hl5hSyR5M48qX
         0IPsGhDFHmzedwYhjqPSKXxSwEpjaF1SjvuJ0FK0DlG2SceDEdslkMbvqyN5w454YJEj
         OuwD5C0GKsFxYOH/fjS9taQ1Fao+rvVL7X1AVWbbtq3PQMNMju9lJvlRQgAV3ZyrxHfz
         Zj6wGdAz4K8h7+DjIXPxytnFabB1ZqrIkvVfNl+Es1B4BNAEYSyFz5+rL/yTVGZXslMS
         T9YRxz1/wbsN4CzseBltb1yCaLMVpoVxf5u9viLfyDTGM5uggapI2PAJl/M2cNZb9nJB
         +HVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=cY7dwSAZ/LRC+V3+VuDl/u0CtvPhkHUKtwYdGP4h8tM=;
        b=RMHT5/h6CUgdSc/0yRyZM0s0mVbobXvyVqfA+oKKvrAeSR4Lc0r6jyTSXT7e/P0E0X
         GlgTldK6jN0y2Nm4cbGWWnoj2QyGAKbzSpgRk+F4qd8EwDXGRbOKXoFQ5JlKOATFhxw6
         eTlfLkKVQrOi7qtzWnJML+OR33E056u/cGwHHVZttZRvMXLTCj+XIcwA6STFxZb40Aws
         GkMdjKMGoVsp2XXJzVXaut/uITHYfcF6ek0S0F4Bcg/WhG/9+GYKGxDcbJosxAjHKvak
         a3T4bmzlJKp8yXajbWn5eXrTVq+a8C/cmsn4la3dKs8goeqveg7LM6SU9o/k8XKooygR
         X2Yw==
X-Gm-Message-State: APjAAAVPjRvcNqvwQTuBqa+J1fViD7Nf7o1OM9epKhg6SJBx5u12wJxa
        ZQTxKnrEg93PUXGG19MHNTM=
X-Google-Smtp-Source: APXvYqwyDNBYMAZlSJRkUJmx4zksig6ZCgUKH4qEh9uQ/wdnO/i0VrSvc1T2/bEhZTtSydu35p/6UQ==
X-Received: by 2002:ae9:e810:: with SMTP id a16mr5237472qkg.364.1570121154872;
        Thu, 03 Oct 2019 09:45:54 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::3:9f72])
        by smtp.gmail.com with ESMTPSA id c131sm1941291qke.24.2019.10.03.09.45.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Oct 2019 09:45:54 -0700 (PDT)
Date:   Thu, 3 Oct 2019 09:45:52 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     hannes@cmpxchg.org, clm@fb.com, dennisz@fb.com,
        Josef Bacik <jbacik@fb.com>, kernel-team@fb.com,
        newella@fb.com, lizefan@huawei.com, axboe@kernel.dk,
        Paolo Valente <paolo.valente@linaro.org>,
        Rik van Riel <riel@surriel.com>, josef@toxicpanda.com,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/10] blkcg: implement blk-iocost
Message-ID: <20191003164552.GA3247445@devbig004.ftw2.facebook.com>
References: <20190828220600.2527417-1-tj@kernel.org>
 <20190828220600.2527417-9-tj@kernel.org>
 <20190910125513.GA6399@blackbody.suse.cz>
 <20190910160855.GS2263813@devbig004.ftw2.facebook.com>
 <20191003145106.GC6678@blackbody.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191003145106.GC6678@blackbody.suse.cz>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Thu, Oct 03, 2019 at 04:51:06PM +0200, Michal Koutný wrote:
> > Initially, I put them under block device sysfs but it was too clumsy
> > with different config file formats and all.
> Do you have any more details on that? In the end, it all boils down to a
> daemon/setup utility writing into the control files and it can use
> whatever config files it decides, can't it?

Yeah, I mean, we can make any interface work.  So, there are two
global knobs io.cost.model and io.cost.qos.  Of the tw, io.cost.model
is okay to move under block device but the qos file gets weird because
the content of the file is more resource control policies than device
properties.

Thanks.

-- 
tejun
