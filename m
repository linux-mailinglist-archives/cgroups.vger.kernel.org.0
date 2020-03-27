Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D73A6194E67
	for <lists+cgroups@lfdr.de>; Fri, 27 Mar 2020 02:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbgC0B1D (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 26 Mar 2020 21:27:03 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:24232 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727122AbgC0B1D (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 26 Mar 2020 21:27:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585272422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MUJ4EFBey4RnBsubrV8OieVsspJ5+/9YngaSQHIcXsM=;
        b=FmAGWk3pfgjcv7CMqfecffcpZ52rcWYxrPNQk5dMBUa8NJGCyKXmvAwURhF5+kQ4UVrTXu
        XwgELMgErEGWB0FIVO815I8FgezE9ujIdxwm+bUNEFh18rc8JJdSRBik1GxhZnKjgnWws3
        pt6Lgp/ckK+BcT8FBsnfDsg6uTNmQJY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-305-4cO3SvUDMUK6LNiuW7ZcNA-1; Thu, 26 Mar 2020 21:26:58 -0400
X-MC-Unique: 4cO3SvUDMUK6LNiuW7ZcNA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A6AA6800D6C;
        Fri, 27 Mar 2020 01:26:55 +0000 (UTC)
Received: from llong.remote.csb (ovpn-117-112.rdu2.redhat.com [10.10.117.112])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 73F9C60BF3;
        Fri, 27 Mar 2020 01:26:52 +0000 (UTC)
Subject: Re: [PATCH RFC] cpuset: Make cpusets get restored on hotplug
To:     Joel Fernandes <joel@joelfernandes.org>, Tejun Heo <tj@kernel.org>
Cc:     Sonny Rao <sonnyrao@google.com>, linux-kernel@vger.kernel.org,
        Dmitry Shmidt <dimitrysh@google.com>,
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
 <20200326201649.GQ162390@mtj.duckdns.org>
 <20200326202340.GA146657@google.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <592d4120-0b42-4607-5efd-fb2d4d29f0cc@redhat.com>
Date:   Thu, 26 Mar 2020 21:26:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200326202340.GA146657@google.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 3/26/20 4:23 PM, Joel Fernandes wrote:
> On Thu, Mar 26, 2020 at 04:18:59PM -0400, Tejun Heo wrote: >> On Thu, Mar 26, 2020 at 01:05:04PM -0700, Sonny Rao wrote: >>> I am
surprised if anyone actually wants this behavior, we (Chrome >>> OS) >>
>> The behavior is silly but consistent in that it doesn't allow empty
>> active cpusets and it has been like that for many many years now. >>
>>> found out about it accidentally, and then found that Android had >>>
been carrying a patch to fix it. And if it were a desirable >>> behavior
then why isn't it an option in v2? >> >> Nobody is saying it's a good
behavior (hence the change in cgroup2) >> and there are situations where
changing things like this is >> justifiable, but, here: >> >> * The
proposed change makes the interface inconsistent and does so >>
unconditionally on what is now a mostly legacy interface. >> >> * There
already is a newer version of the interface which includes >> the
desired behavior. >> >> * I forgot but as Waiman pointed out, you can
even opt-in to the >> new behavior, which is more comprehensive without
the >> inconsitencies, while staying on cgroup1. > > Thank you Tejun,
Waiman and Sonny. I confirmed the cgroup_v2_mode > option fixes cgroup
v1's broken behavior. > > We will use this mount option on our systems
to fix it.
I am glad that it works for you.

I think the problem is that the v2_mode mount option is not that well
documented. Maybe I should send a patch to add some some description
about it in cgroup-v2.rst or cgroup-v1/cpusets.rst.

Cheers,
Longman



