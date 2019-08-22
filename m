Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC3D995A6
	for <lists+cgroups@lfdr.de>; Thu, 22 Aug 2019 15:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731971AbfHVN61 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 22 Aug 2019 09:58:27 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37605 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731614AbfHVN61 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 22 Aug 2019 09:58:27 -0400
Received: by mail-qt1-f196.google.com with SMTP id y26so7786930qto.4
        for <cgroups@vger.kernel.org>; Thu, 22 Aug 2019 06:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SPj+gL+0mYPmQFP5JGWSNorkU++xc1v51BhWWyhxmsA=;
        b=lMqTvjDCInqOVQIO2st9JKxYoxSWuzXuB/WUqrO70gJRbC6ZldPUn9fB6wU0tLO6eS
         IVyzqetocPFlw45Mh9fpNBux/DJ8TrjsSzNWyDnG08wCqpP2xoRkDI77+vhrW7yXVn0P
         1BNQ7sMLDvv0phZAFzpx2pA6EH4obWhzLL9W/PYA/leAD/3Jvgck0dEoMWkUrYO2FBUB
         m6YkhIfzb5lLv0hmkFo44NQbMIcp4sbG/nmj9UY6G8D/jF4zyFBdwAwT3knXyUQ3Q+kt
         fIRAQ4BhgWrOIWCkrGo9DCnbCPMChz9lvLiNomVHsE1f0umQSGXxJqOsCTY3tGSF0lWL
         H2bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=SPj+gL+0mYPmQFP5JGWSNorkU++xc1v51BhWWyhxmsA=;
        b=SRMoYGjjNyRjTSZs9LY65r4DgIakw1h/EvIZVNIQ5+5orzIf8m6vTNznd1za5uSrs8
         6d5Q55IiWW7P9vR49Hoq8sn99qzbKm0zr2bBoYioK5j0WlI8bykJc7xI2GC0Cj4f9XJP
         7TnNMT2BHROOLJ94Sc4V33Ko0iwhpl0Lf4IOPb/H6dIZHPYWtZbPKikzoDEqo6sU12y8
         tBE5YMV9hEe8JNf/fLQqTExhfIjQKWgrpi4XZgfq0zTDnUW/oWwwpOYEQgVvyZ/3vorJ
         VmSC2ds3cnKXY+0G7Ndng5RAZJYn9jaL3nzpNHSXzfGthgRYwU1F90sVN9bWVHDAGE6Q
         RG3Q==
X-Gm-Message-State: APjAAAV82IKxAm6dfFdU2sZYRYEIvQfimAI5O7c5pjBfKAa70WIaVHU7
        W8UEgTmtt/VTOpyWYCRTu5+n+e6N
X-Google-Smtp-Source: APXvYqxejdj6ot1QqliONa1sfPBuhkuHIsJkRCxcR6H3Fmerp9mYHAkeZFdIYuVZ7XaaYkyw9q2fyQ==
X-Received: by 2002:a0c:99ee:: with SMTP id y46mr20764542qve.54.1566482306432;
        Thu, 22 Aug 2019 06:58:26 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::1:1f05])
        by smtp.gmail.com with ESMTPSA id v23sm10950887qtq.40.2019.08.22.06.58.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Aug 2019 06:58:25 -0700 (PDT)
Date:   Thu, 22 Aug 2019 06:58:23 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     cgroups@vger.kernel.org, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, tglx@linutronix.de
Subject: Re: [PATCH 1/4] cgroup: Remove ->css_rstat_flush()
Message-ID: <20190822135823.GO2263813@devbig004.ftw2.facebook.com>
References: <20190816111817.834-1-bigeasy@linutronix.de>
 <20190816111817.834-2-bigeasy@linutronix.de>
 <20190821155329.GJ2263813@devbig004.ftw2.facebook.com>
 <20190822082032.qyy2isvvtj5waymx@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190822082032.qyy2isvvtj5waymx@linutronix.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Aug 22, 2019 at 10:20:32AM +0200, Sebastian Andrzej Siewior wrote:
> On 2019-08-21 08:53:29 [-0700], Tejun Heo wrote:
> > On Fri, Aug 16, 2019 at 01:18:14PM +0200, Sebastian Andrzej Siewior wrote:
> > > I was looking at the lifetime of the the ->css_rstat_flush() to see if
> > > cgroup_rstat_cpu_lock should remain a raw_spinlock_t. I didn't find any
> > > users and is unused since it was introduced in commit
> > >   8f53470bab042 ("cgroup: Add cgroup_subsys->css_rstat_flush()")
> > > 
> > > Remove the css_rstat_flush callback because it has no users.
> > > 
> > > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > 
> > Yeah, I'd rather keep it.  The patch which used this didn't get merged
> > but the use case is valid and it will likely be used for different
> > cases.
> 
> I was afraid that the inner while loop in cgroup_rstat_flush_locked()
> could get too long with the css_rstat_flush() here. Especially if it
> acquires spin locks. But since this is not currently happening...
> Any objections to the remaining series if I drop this patch?

Nack for the whole series.  Please stop mixing interface and locking
changes.

Thanks.

-- 
tejun
