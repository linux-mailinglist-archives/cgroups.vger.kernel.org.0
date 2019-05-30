Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC5B3015D
	for <lists+cgroups@lfdr.de>; Thu, 30 May 2019 19:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbfE3R6E (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 30 May 2019 13:58:04 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35868 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbfE3R6E (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 30 May 2019 13:58:04 -0400
Received: by mail-pf1-f193.google.com with SMTP id u22so4440383pfm.3
        for <cgroups@vger.kernel.org>; Thu, 30 May 2019 10:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UdtCpjjQ91i6JdeO1o6cmQH2Jj5NVts/neyKdRuf9u0=;
        b=V8J8o0JH07x2wsBm99n7DGytzSCB9uQ7i73/R7tiHi2EW+jlFvc9gPYtl/fH4Vtxfk
         8+4Cfa4e63aA5rrFDRaRFWVlXZO4x+21PiB/3o4FZZJOF0sMkYhr4qoWdTzCynaKwyPZ
         kBcIAAH67jJTafpsCBQrUe1ANdMKdiKshInIwRJ+BUPz/kaCKBTlvGwLD0vk0Cy79OFL
         pQV8FyejxTWwBSkNkb2i0W+gU4dNKH5fQz3CURzx8VpGqok0gIMOvcEsrvCSRBvJK1VB
         UpIQ+Vac+NqKi2v6odcKj9Za3/R+Om3zqq5+o43oUOnVrotaFmWZapzBt60tB2lW5z7V
         S6vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UdtCpjjQ91i6JdeO1o6cmQH2Jj5NVts/neyKdRuf9u0=;
        b=sEy6ZjTdOhof24TY+Ttslpwc2ekGRha+W0utF8C6hjeUC486x0qX67J3Abzef8baTN
         ckKrtsOxZm9bs2Ob5IBm2qvfWw9he6aICHa60aXdE44DRbgrhM5kuJ4Ro6vSBMO/4dXU
         7K/rQ8NP5zenD8dbpjZe/1xy/ZUCbEDvCVue3RcWLx6mgLvJQoNTiB83h1EL/krM4Kbw
         gjsdFCFEO6nQHvWDNmaykKfKn8AlPyTEgJmJwNPo2Dk3mOR1App3+sDFx7AHlLruTlAy
         1GVu0wiZwwl4M3fIeTxMXdUHPb6+Uee8OY9FbRDV0TXK5Y+rP6IvSuhtHVY/ZL4MI51f
         sS+A==
X-Gm-Message-State: APjAAAU6BWC/mLiU5ueT9DCSYhzwuvLlYZgonPnvrUviHFqwIqlebJ2M
        FXWkS1MkH9P4TfCijH8hWg0SpA==
X-Google-Smtp-Source: APXvYqzy2V8ZQUSqq4q5Py2O0ZZ+w6f/HjgTMagL9FbXBX1DIOdqD+h8jSz65+ynIN0EAeD3DVxpFw==
X-Received: by 2002:a63:fe51:: with SMTP id x17mr4712540pgj.339.1559239083470;
        Thu, 30 May 2019 10:58:03 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::7ef9])
        by smtp.gmail.com with ESMTPSA id d186sm3003141pgc.58.2019.05.30.10.58.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 May 2019 10:58:02 -0700 (PDT)
Date:   Thu, 30 May 2019 13:58:00 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] mm: fix page cache convergence regression
Message-ID: <20190530175800.GA10941@cmpxchg.org>
References: <20190524153148.18481-1-hannes@cmpxchg.org>
 <20190524160417.GB1075@bombadil.infradead.org>
 <20190524173900.GA11702@cmpxchg.org>
 <20190530161548.GA8415@cmpxchg.org>
 <20190530171356.GA19630@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530171356.GA19630@bombadil.infradead.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, May 30, 2019 at 10:13:56AM -0700, Matthew Wilcox wrote:
> On Thu, May 30, 2019 at 12:15:48PM -0400, Johannes Weiner wrote:
> > Are there any objections or feedback on the proposed fix below? This
> > is kind of a serious regression.
> 
> I'll drop it into the xarray tree for merging in a week, if that's ok
> with you?

That sounds great, thank you.
