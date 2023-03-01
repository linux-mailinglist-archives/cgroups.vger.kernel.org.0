Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B439D6A6E60
	for <lists+cgroups@lfdr.de>; Wed,  1 Mar 2023 15:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbjCAO1k (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 1 Mar 2023 09:27:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjCAO1j (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 1 Mar 2023 09:27:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979BFFF2E
        for <cgroups@vger.kernel.org>; Wed,  1 Mar 2023 06:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677680805;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dFfI+7W5JfA3qjbiFdEfsYsg+z7lgNEBSS9MtpBoNwc=;
        b=DWz4MhntBjcD/weHeM8SjflkOT2DjyhI5sSoSUfcJKCixGYCYkr7Z1yC5jGBn5oSYalUkk
        aV8N2hJ+sEij8T4IgY1B9ZQnCjZFh97W1NM0lm1a81ecc/lUNJihdytsAMSBwlqZDgfVW0
        HIkmjEruCNHoClsy6cSVg/3TuC20JtI=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-270-5w5r1PtXPKiAjjEqZnZvCg-1; Wed, 01 Mar 2023 09:26:42 -0500
X-MC-Unique: 5w5r1PtXPKiAjjEqZnZvCg-1
Received: by mail-qk1-f197.google.com with SMTP id ea22-20020a05620a489600b00742cec04043so3363122qkb.7
        for <cgroups@vger.kernel.org>; Wed, 01 Mar 2023 06:26:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dFfI+7W5JfA3qjbiFdEfsYsg+z7lgNEBSS9MtpBoNwc=;
        b=kWCzud3ZXlJs4hrd4Tk+Oz0+YoDuqmVYm4p8clqmOgJyYpCKsDA7Vt79jSOGtgcBem
         0J0q1PLNmTgMfj9Y83ddNNfT2gFv/SkMiVCqv3eN878fRKEe43bBDV8iWBw/uSxzw9Mu
         W/dqMXdbdG1Kor3Go9v70THOeX4GY+gzLLBSsZevMs2qPfLcKJ3aLaqhcO4ZCVTzc0FG
         tkp+yuYOsDUz2VWptQ9aiVZ5eJDEvriQob6UmLJTmZpwaaySes3hfQ/aAdQ60LeAagmM
         IuKwJcEdDeaXN3cwAx2XUhd6X7HRgq/sdEJMISaC57+w7QP5pFF0pmKNyQbVvhSRg3jf
         Cxfg==
X-Gm-Message-State: AO0yUKUnklQ6Znp8heB8c3/oh3/+1yin8lMBltv3tXdxBxtDgmSFsqVM
        Tj3QIt62UEJqjdRxG9R5wv8uME3AHnHIJ2kDEVkZJaiBtQniAhb3fqefI5Cko+9igmOshxNR+g2
        DA7qzUX6RXDHxP5d/mg==
X-Received: by 2002:a05:622a:181c:b0:3bf:cfe8:f8f6 with SMTP id t28-20020a05622a181c00b003bfcfe8f8f6mr10180740qtc.68.1677680801300;
        Wed, 01 Mar 2023 06:26:41 -0800 (PST)
X-Google-Smtp-Source: AK7set/5VAZOkUbaqOOwIEqEvngFddl9X3uCbgwdB202WlT7tWrpgWISNHEX56CELo/zqgPKbTMuHQ==
X-Received: by 2002:a05:622a:181c:b0:3bf:cfe8:f8f6 with SMTP id t28-20020a05622a181c00b003bfcfe8f8f6mr10180697qtc.68.1677680800970;
        Wed, 01 Mar 2023 06:26:40 -0800 (PST)
Received: from localhost.localdomain ([151.29.151.163])
        by smtp.gmail.com with ESMTPSA id n3-20020ac86743000000b003bfbf3afe51sm8259781qtp.93.2023.03.01.06.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 06:26:40 -0800 (PST)
Date:   Wed, 1 Mar 2023 15:26:32 +0100
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Qais Yousef <qyousef@layalina.io>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>, tj@kernel.org,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org,
        cgroups@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Wei Wang <wvw@google.com>, Rick Yiu <rickyiu@google.com>,
        Quentin Perret <qperret@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Zefan Li <lizefan.x@bytedance.com>, linux-s390@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH v3] sched: cpuset: Don't rebuild root domains on
 suspend-resume
Message-ID: <Y/9gmDRlGOChIwpf@localhost.localdomain>
References: <20230206221428.2125324-1-qyousef@layalina.io>
 <20230223153859.37tqoqk33oc6tv7o@airbuntu>
 <5f087dd8-3e39-ce83-fe24-afa5179c05d9@arm.com>
 <20230227205725.dipvh3i7dvyrv4tv@airbuntu>
 <5a1e58bf-7eb2-bd7a-7e19-7864428a2b83@arm.com>
 <20230228174627.vja5aejq27dsta2u@airbuntu>
 <Y/7/SLzvK8LfB29z@localhost.localdomain>
 <20230301122852.zgzreby42lh2zf6w@airbuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230301122852.zgzreby42lh2zf6w@airbuntu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 01/03/23 12:28, Qais Yousef wrote:
> On 03/01/23 08:31, Juri Lelli wrote:

...

> > Not ignoring you guys here, but it turns out I'm quite bogged down with
> > other stuff at the moment. :/ So, apologies and I'll try to get to this
> > asap. Thanks a lot for all your efforts and time reviewing so far!
> 
> Np, I can feel you :-)

Eh. :/

BTW, do you have a repro script of some sort handy I might play with?

