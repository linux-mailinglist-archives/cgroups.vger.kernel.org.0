Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4D8194AE4
	for <lists+cgroups@lfdr.de>; Thu, 26 Mar 2020 22:47:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbgCZVrq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 26 Mar 2020 17:47:46 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:41622 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726260AbgCZVrp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 26 Mar 2020 17:47:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585259264;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d/7D0H39fzxBW1aDOQOylNWNd9Qe3dOSz4cHq2u2z+8=;
        b=Lnjo+MvL9fLiRTYr0AMWF3Qkyk+E+9HADcsAQYagUUiQcSOi1vi9H9eAsYCm1+dVk19xRz
        MZtkmQDGqHZJ9trENSfMw7hr0OzmGOIQxR9E5b4f5Q3+4z2r+jeHbEP7hlDBje3tDLdf+L
        +RHGdzEEtok4AkCIKeMcspAGTeJjm2Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-Za6QPCxyOTqu3ComYKIBKQ-1; Thu, 26 Mar 2020 17:47:42 -0400
X-MC-Unique: Za6QPCxyOTqu3ComYKIBKQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 46A16107ACC4;
        Thu, 26 Mar 2020 21:47:40 +0000 (UTC)
Received: from llong.remote.csb (ovpn-117-112.rdu2.redhat.com [10.10.117.112])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E82FA19C69;
        Thu, 26 Mar 2020 21:47:36 +0000 (UTC)
Subject: Re: [PATCH RFC] cpuset: Make cpusets get restored on hotplug
To:     Sonny Rao <sonnyrao@google.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>, Tejun Heo <tj@kernel.org>,
        linux-kernel@vger.kernel.org, Dmitry Shmidt <dimitrysh@google.com>,
        Amit Pundir <amit.pundir@linaro.org>, kernel-team@android.com,
        Jesse Barnes <jsbarnes@google.com>, vpillai@digitalocean.com,
        Peter Zijlstra <peterz@infradead.org>,
        Guenter Roeck <groeck@chromium.org>,
        Greg Kerr <kerrnel@google.com>, cgroups@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Li Zefan <lizefan@huawei.com>
References: <20200326191623.129285-1-joel@joelfernandes.org>
 <20200326192035.GO162390@mtj.duckdns.org>
 <20200326194448.GA133524@google.com>
 <972a5c1b-6721-ac20-cec5-617af67e617d@redhat.com>
 <CAPz6YkVUsDz456z8-X2G_EDd-uet1rRNnh2sDUpdcoWp_fkDDw@mail.gmail.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <e9093ab2-f61f-edf1-5da7-fce5101d6dbf@redhat.com>
Date:   Thu, 26 Mar 2020 17:47:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAPz6YkVUsDz456z8-X2G_EDd-uet1rRNnh2sDUpdcoWp_fkDDw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 3/26/20 4:05 PM, Sonny Rao wrote:
>> I think Tejun is concerned about a change in the default behavior of
>> cpuset v1.
>>
>> There is a special v2 mode for cpuset that is enabled by the mount
>> option "cpuset_v2_mode". This causes the cpuset v1 to adopt some of the
>> v2 behavior. I introduced this v2 mode a while back to address, I think,
>> a similar concern. Could you try that to see if it is able to address
>> your problem? If not, you can make some code adjustment within the
>> framework of the v2 mode. As long as it is an opt-in, I think we are
>> open to further change.
> I am surprised if anyone actually wants this behavior, we (Chrome OS)
> found out about it accidentally, and then found that Android had been
> carrying a patch to fix it.  And if it were a desirable behavior then
> why isn't it an option in v2?
>
I am a bit confused. The v2 mode make cpuset v1 behaves more like cpuset
v2. The original v1 behavior has some obvious issue that was fixed in
v2. So what v2 option are you talking about?

Regards,
Longman

