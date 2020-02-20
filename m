Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5DD5165349
	for <lists+cgroups@lfdr.de>; Thu, 20 Feb 2020 01:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbgBTADn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 19 Feb 2020 19:03:43 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:40770 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbgBTADn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 19 Feb 2020 19:03:43 -0500
Received: by mail-oi1-f195.google.com with SMTP id a142so25717784oii.7
        for <cgroups@vger.kernel.org>; Wed, 19 Feb 2020 16:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YHeIdmxOoP0hF/CsX1z22j/VcXTF+m2n9SPCMuF9eo0=;
        b=Q0qIGLPNuwluFhVMJjoUI0Nx6z7pyTSN7DOfAsbF6qO5OaYP+p/1yvW2zX1CgLr2HR
         K0OgeL1DtnewH8OGFkdUlXrehmNjgUiIXmJO2aiXfD6jEWvT99CQpYWm9279KjIQ4rbC
         Ya0A4bWv87EWS8lzBJ0Q7f88+9UwlAhD77pFZTnGu/UdG670VRiS2sIULtT46781IhuI
         YbiRP83N+GEklKllMDq1Vek5xCN/2MVOULroAXTqfgQk29icTjdS+Vg05p3ZdJgbNefK
         Z73ntL+t70lQkgEHoyThAMI7NElrteSsI7AX1PvyU62Z0Q5z5sqdYuGQTfs1sARnFNO2
         vIgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YHeIdmxOoP0hF/CsX1z22j/VcXTF+m2n9SPCMuF9eo0=;
        b=k0z7U/hoTbp3C06UZP2YWxr0LmGMriQhLxxiZ2vTJ7go2944AgdhTVNAprlfX8H+xb
         MJG4giVcbZC/mlMNnWKmHvtDu7dmbq3qn6H9pFk2EzXddEdIG0Hk2+7zeJUxfKsM33kI
         R0QWBTmhuFz8tRmz1nLektja4HfXxnq9eCSZzXU/iKFQidbvWGthagvkzVqnAGrPKyW3
         zgQtZ15Z9W/Z4yTrtaux/18337IVnJkeLhTan+58wsIBdWfiUTK7tK+wDz2MiYqjF6/r
         mHFwunsf5O4PEgmA3vZMlI7Etzht0kvb5wWUov8xtE6HVCDiXZuIc7BauKiFqvLqWDu1
         hx0A==
X-Gm-Message-State: APjAAAUzkpSGRClDeJutI96mjAZuDqTjQ5csnJOfYP2ZTDSCU3IISIkT
        0BxnHRt36lFhrX2UyJAThQyE3WA7/IYB2fTBDNoA2g==
X-Google-Smtp-Source: APXvYqy4o4y6JMY/d+GfmgPPn6aadmNotKQEgu1SrOfear8zoHkmyiLy8ANr0b88zOSHe3kLSAM67virA8+YlW+Y1os=
X-Received: by 2002:a54:4086:: with SMTP id i6mr173786oii.65.1582157020886;
 Wed, 19 Feb 2020 16:03:40 -0800 (PST)
MIME-Version: 1.0
References: <20200211213128.73302-1-almasrymina@google.com> <20200211213128.73302-9-almasrymina@google.com>
In-Reply-To: <20200211213128.73302-9-almasrymina@google.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Wed, 19 Feb 2020 16:03:29 -0800
Message-ID: <CAHS8izPfaq=rfUrQGDyOwbgZhw96Qbos9xAdJzs35KyLB_JZ-A@mail.gmail.com>
Subject: Re: [PATCH v12 9/9] hugetlb_cgroup: Add hugetlb_cgroup reservation docs
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     shuah <shuah@kernel.org>, David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Feb 11, 2020 at 1:32 PM Mina Almasry <almasrymina@google.com> wrote:
>
> Add docs for how to use hugetlb_cgroup reservations, and their behavior.
>
> Signed-off-by: Mina Almasry <almasrymina@google.com>
>

Hi folks,

By my count this patch and the tests are the only patches in the
series awaiting review. Can you folks give it a look?

Thanks in advance!
