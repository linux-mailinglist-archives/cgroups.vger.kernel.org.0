Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 582E4147257
	for <lists+cgroups@lfdr.de>; Thu, 23 Jan 2020 21:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbgAWUFp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 23 Jan 2020 15:05:45 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36576 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbgAWUFm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 23 Jan 2020 15:05:42 -0500
Received: by mail-oi1-f195.google.com with SMTP id c16so4167122oic.3
        for <cgroups@vger.kernel.org>; Thu, 23 Jan 2020 12:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VyznYH5jQ6Vy0xxWHMJMOnmd05+7Te8s8tuSLOem1vc=;
        b=NEFtawHLgzySPes5yhMKn043r+gEGRFGKhG2aJibWy+YdIIw0CJVynUf/h7t5SDCAn
         YCLGg0okwgHeebwoD2fSmlXxTPzE+8OqgOFxOfSXKIjZI6xLy+zqNphZwdd2Tl3HNdb9
         F+bOjMFMa/rjrcxnOi4Uv4WZy/wdxN2W8Nb0aKewvUoYFlPfCCwLGvMXURaKpP3IPhAy
         Vp7d3t7P3GCpDZy5GL/uWB/BtJVgZPiTYeU3t+OjdbL0MzYC+L/KPsM2qvjVN1iPjPEf
         Ccr0Fq0QlZZfD85rtYSLJWpgC5B4L6fMT7Gk1Ub9GJZ/JSAOlZbDhxtdfgH8LTyMuqxP
         +XHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VyznYH5jQ6Vy0xxWHMJMOnmd05+7Te8s8tuSLOem1vc=;
        b=hzoIi8jiiqhF5U5pp6JJqYNDNwXitUVUNPpSusUoa3tYykUopx42MtHsI6ek6t49S8
         KieYa5dyCQUaZb9zr7Zx/rXfC13+oT/RsC/5plvSgYTWxrExQllvIElbkUmrObmnH2kn
         Oq6YgwRs/pKWVvqf7c54S/l5m5Nhe1SbrXB/2nNYJJFCodolkFWEx8/UOmLt/UInNADJ
         3uhbHv+CSccz80VYlL55W9+8UYu4iFtM6e/xFL9gFoJyve7icw3QuixePPmG4CHVvp6m
         MXr0COPOOx/vI0evXOJFxGcHUtyZO3yqM61nDaWeD2/IZEKOBbhEJK39/lF2Kty9LIY/
         0voA==
X-Gm-Message-State: APjAAAVZtIBpw3VrN2SYY9R3lWK4/qg4z1M8hDXSPP7D6AUimeVW/vw4
        AfkP3lu3uFUPcq/EnKNip59rsXqeKlzTGLfBxWoU7w==
X-Google-Smtp-Source: APXvYqwiRj0OJ5VwDvTDPamb1fxJTDNZ4OLpyrc6B4XIYJ2G1RIHK15Xy+a0L15Xtv0x5GzGRu8QZoxzo7UGUwseUng=
X-Received: by 2002:aca:b3d6:: with SMTP id c205mr12152720oif.67.1579809941388;
 Thu, 23 Jan 2020 12:05:41 -0800 (PST)
MIME-Version: 1.0
References: <20200115012651.228058-1-almasrymina@google.com>
 <20200115012651.228058-7-almasrymina@google.com> <7ce6d59f-fd73-c529-2ad6-edda9937966d@linux.ibm.com>
In-Reply-To: <7ce6d59f-fd73-c529-2ad6-edda9937966d@linux.ibm.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Thu, 23 Jan 2020 12:05:30 -0800
Message-ID: <CAHS8izNmhxja_0+b2DudpXB+1DQfpnjUu+Qak+wnsApgYrvU=Q@mail.gmail.com>
Subject: Re: [PATCH v10 7/8] hugetlb_cgroup: Add hugetlb_cgroup reservation tests
To:     Sandipan Das <sandipan@linux.ibm.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>, shuah <shuah@kernel.org>,
        Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org,
        Aneesh Kumar <aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Jan 23, 2020 at 1:15 AM Sandipan Das <sandipan@linux.ibm.com> wrote:
>
> For powerpc64, either 16MB/16GB or 2MB/1GB huge pages are supported depending
> on the MMU type (Hash or Radix). I was just running these tests on a powerpc64
> system with Hash MMU and ran into problems because the tests assume that the
> hugepage size is always 2MB. Can you determine the huge page size at runtime?
>

Absolutely. Let me try to reproduce this failure and it should be
fixed in the next patchset version.
