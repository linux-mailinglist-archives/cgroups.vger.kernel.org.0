Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66CDB10AF99
	for <lists+cgroups@lfdr.de>; Wed, 27 Nov 2019 13:34:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfK0Mec (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 27 Nov 2019 07:34:32 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53328 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726520AbfK0Mec (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 27 Nov 2019 07:34:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574858071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CVCxFShIZBap1xvsiIElKGQV+WwEAt1akv1J1GsrbWg=;
        b=NlL2+ASRsHEo+porHzliv5B6+5XxjjExBi6dJYgEksfRnSTLShjCvZEwXAPaFK4VKyiv5M
        jCy3jcarj5KrNr5SNJV7qtf3345kvMp7aMdI479AYNvK+2vqZH5h3sXowdJ19+8vPM7cMy
        cgf1mL7xi1O9RgIZfj8xVYFb+silC+k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-186-WTuYO0YFPn-gEYUIABR-Hg-1; Wed, 27 Nov 2019 07:34:28 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3C1FE1005512;
        Wed, 27 Nov 2019 12:34:27 +0000 (UTC)
Received: from localhost (unknown [10.36.118.34])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C2E9B5C297;
        Wed, 27 Nov 2019 12:34:26 +0000 (UTC)
From:   Giuseppe Scrivano <gscrivan@redhat.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org, mike.kravetz@oracle.com,
        lizefan@huawei.com, hannes@cmpxchg.org, almasrymina@google.com
Subject: Re: [PATCH v2] mm: hugetlb controller for cgroups v2
References: <20191126195600.1453143-1-gscrivan@redhat.com>
        <20191126195908.GA16681@devbig004.ftw2.facebook.com>
Date:   Wed, 27 Nov 2019 13:34:25 +0100
In-Reply-To: <20191126195908.GA16681@devbig004.ftw2.facebook.com> (Tejun Heo's
        message of "Tue, 26 Nov 2019 11:59:08 -0800")
Message-ID: <871rttmram.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: WTuYO0YFPn-gEYUIABR-Hg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Tejun Heo <tj@kernel.org> writes:

>> .failcnt is not provided as a single file anymore, but its value can
>> be read in the new flat-keyed file .events, through the "max" key.
>
> Looks great.  Just one more thin.  The .events are expected to
> generate file changed event when something changes inside so that
> userspace can poll for it.  Can you please implement that for hugetlb
> too?

sure, thanks for spotting it.

Regards,
Giuseppe

