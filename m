Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D57F1164E6A
	for <lists+cgroups@lfdr.de>; Wed, 19 Feb 2020 20:05:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgBSTFx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 19 Feb 2020 14:05:53 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:44454 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbgBSTFx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 19 Feb 2020 14:05:53 -0500
Received: by mail-oi1-f194.google.com with SMTP id d62so24849821oia.11
        for <cgroups@vger.kernel.org>; Wed, 19 Feb 2020 11:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x3W3v+68ig6DpCsCj7cxqvrURO7RlrIPZ7rtuczBdEw=;
        b=MRO7yMzk7yDrFx6YlaBjQipExwOAAl5oZs4Uw3k4YEf0IGCO46qz9pNv7mKfRtdLmz
         PEMy+4mqqmhwK9gt+RfIID4sYXypy6kmfz1f3/bMfc/HE8wlsqQQGiSvYEAjvEeIOtHa
         S6UhvT56lMx/7KvHuGwTFmdLS+x63NJs9cvcUK6OyY4jAYlq0NtF8+Y90oLe3sYVYbZG
         Z4C1gt9hZGvCpniRgDi27fhm9UHQPo3FBAsRTSTIXvJ0SCAfmlCJZJvUqjqxhIhm85Eo
         FcWe5DtoCsHrj7vx/oU+0Nb9bnw/5FAhoH0jlTXQwKcUoHzNp9GTA2nYG/bf1Wm2UWLP
         W65w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x3W3v+68ig6DpCsCj7cxqvrURO7RlrIPZ7rtuczBdEw=;
        b=U2ubr7xmfzm8PTL38zyHi7MKW8+Xih53lkuN7+lpps1LhePE8VfJoFFeUk+DlFe4RI
         OPGOltVwBILwzSKu6h0l6TI6WYaMCVkefQho40prmt4KWdzn4y2Y6T14t4IVq3yYR/If
         wGFvD9bVeOueEH3z+mTOMIV0L5imxe2Eu3L0puBU3eZlatucvgB4FSISNYoMGEKXcxNh
         WTwvb+6P7cLuox3rFL8NwCmdxI/oeg74F95pyWbGckaOacMHvren5J3Q9yY5pmcbo8kM
         SGsdxL6JkdWxK4Oy67h6ZHVtgWGHEBoO2aAizpd+0hJY5WJ0e+5JzYTvqigu3FsaBXV0
         2yxw==
X-Gm-Message-State: APjAAAWzJBBUiwM5AhYm0xW0PnkCjLmhFvHldP6OTSsinh956Dbidrp3
        ptNcZTF4dqXF7crhwB78YQ7OD48A0tA45yBsOPMSiw==
X-Google-Smtp-Source: APXvYqwEay32tZ67d1pnpiUQv4wvXQaJmUw10KBTCy/isaFzhTkheZJm6RN/SlMhPx5MtBPryEnlPcoCjQaeEkl+B1s=
X-Received: by 2002:aca:1012:: with SMTP id 18mr5372313oiq.151.1582139152379;
 Wed, 19 Feb 2020 11:05:52 -0800 (PST)
MIME-Version: 1.0
References: <20200211213128.73302-1-almasrymina@google.com> <20200211151906.637d1703e4756066583b89da@linux-foundation.org>
In-Reply-To: <20200211151906.637d1703e4756066583b89da@linux-foundation.org>
From:   Mina Almasry <almasrymina@google.com>
Date:   Wed, 19 Feb 2020 11:05:41 -0800
Message-ID: <CAHS8izPUFQWq3PzhhRzp7u11173_-cmRkNuQWEswS51Xz6ZM0Q@mail.gmail.com>
Subject: Re: [PATCH v12 1/9] hugetlb_cgroup: Add hugetlb_cgroup reservation counter
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>, shuah <shuah@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Greg Thelen <gthelen@google.com>,
        open list <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Feb 11, 2020 at 3:19 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Tue, 11 Feb 2020 13:31:20 -0800 Mina Almasry <almasrymina@google.com> wrote:
>
> > These counters will track hugetlb reservations rather than hugetlb
> > memory faulted in. This patch only adds the counter, following patches
> > add the charging and uncharging of the counter.
>
> We're still pretty thin on review here, but as it's v12 and Mike
> appears to be signed up to look at this work, I'll add them to -next to
> help move things forward.
>

Hi Andrew,

Since the patches were merged into -next there have been build fixes
and test fixes and some review comments. Would you like me to submit
*new* patches to address these, or would you like me to squash the
fixes into my existing patch series and submit another iteration of
the patch series?
