Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7AF2164DB8
	for <lists+cgroups@lfdr.de>; Wed, 19 Feb 2020 19:34:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgBSSeP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 19 Feb 2020 13:34:15 -0500
Received: from mail-wr1-f46.google.com ([209.85.221.46]:46713 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbgBSSeP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 19 Feb 2020 13:34:15 -0500
Received: by mail-wr1-f46.google.com with SMTP id z7so1677847wrl.13
        for <cgroups@vger.kernel.org>; Wed, 19 Feb 2020 10:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=td5aeW+QPYB+KB8i1zHwXZM09cfU1cge9VUSnerPS+U=;
        b=VKG3ayHx1PbU3tzLbzbMq5g5DlCaXhEcvfmhrRse/ghrZQh/huPTahTdzQ4rfA3+3f
         fHmme/jWx7V6SxKXRl+qaIqfcD61gJ+ET7OdZsD+1W9ZdYw8j7iSNoXAjJyMwOgpkdkP
         2KFL9gSr95bVlMmFXuT3fGomo5K0p0H0wyiGgfNQUNg4myyxdYsGEy64VCUlkeKioVC5
         ckSXzXdv9XL01DvhQLtR8NWWGzCMNcuJKk375EB5Jrt1UTQzy+vPSr3DAV0QaI0W7QEB
         FzNb7x3+QzzUT6xISG2bK2OOnHxAh8Ogc+Jb6DQYGny9ZJTpdmbzxPO2yqoBIeoA3/K6
         9qqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=td5aeW+QPYB+KB8i1zHwXZM09cfU1cge9VUSnerPS+U=;
        b=TEzYldJhnLhm/y77LWaitwItWxib+ao+m7j3V5gr+s3aaRYY6T9yxOqteHwImQipsE
         XDe8QcK8JcgJBRx2/WfZ9FEseCEmpJZIoCYSBXXCZuNfL0FcYXM8NL96oxp8Nx3UClZI
         NtcIZxEDvBqd+zfTXmtW/eV4oaawCTB7uPsFRNBwy9hj/73Oxl/n5/i+hKXPJHYHI0ZM
         tjD5mOOh1julNX4mReXhcw0nKDT3RY2qL9IsJdk+oIFinHY7NWA65pLzv7w3vF9N6IAT
         49vunf3ISu6nOZJPFHvCxCeI7U/Vi4JOY6ecy29sxCpvH1KefdZIxwNwYPSEXhovUAFH
         JCYA==
X-Gm-Message-State: APjAAAUbWtk0g+XqrRAI4yW1j9/jMCp3aA/aLknAojLg0L6DyFS+cWNR
        xVZ33BSRWRJHFU0IwPnOjVafHQ==
X-Google-Smtp-Source: APXvYqxH3ZFStoAuiRV1Lv5s6KP9VRqhXYYhReWZXDYJOj9/2wVG+8ZKnhQ0qB3qQbWRg5heCwGSJw==
X-Received: by 2002:a5d:674d:: with SMTP id l13mr36598333wrw.11.1582137250656;
        Wed, 19 Feb 2020 10:34:10 -0800 (PST)
Received: from [192.168.0.102] (88-147-55-13.dyn.eolo.it. [88.147.55.13])
        by smtp.gmail.com with ESMTPSA id y8sm821537wma.10.2020.02.19.10.34.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Feb 2020 10:34:09 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCHSET block/for-next] IO cost model based work-conserving
 porportional controller
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20190906145826.GL2263813@devbig004.ftw2.facebook.com>
Date:   Wed, 19 Feb 2020 19:34:46 +0100
Cc:     Jens Axboe <axboe@kernel.dk>, newella@fb.com, clm@fb.com,
        Josef Bacik <josef@toxicpanda.com>, dennisz@fb.com,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>, kernel-team@fb.com,
        cgroups@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        bpf@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <F4AB45F1-6B02-4C15-B845-EDE610357F02@linaro.org>
References: <5A63F937-F7B5-4D09-9DB4-C73D6F571D50@linaro.org>
 <B5E431F7-549D-4FC4-A098-D074DF9586A1@linaro.org>
 <20190820151903.GH2263813@devbig004.ftw2.facebook.com>
 <9EB760CE-0028-4766-AE9D-6E90028D8579@linaro.org>
 <20190831065358.GF2263813@devbig004.ftw2.facebook.com>
 <88C7DC68-680E-49BB-9699-509B9B0B12A0@linaro.org>
 <20190902155652.GH2263813@devbig004.ftw2.facebook.com>
 <D9F6BC6D-FEB3-40CA-A33C-F501AE4434F0@linaro.org>
 <20190905165540.GJ2263813@devbig004.ftw2.facebook.com>
 <EFFA2298-8614-4AFC-9208-B36976F6548C@linaro.org>
 <20190906145826.GL2263813@devbig004.ftw2.facebook.com>
To:     Tejun Heo <tj@kernel.org>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Tejun
sorry for the long delay, but, before replying, I preferred to analyze
io.cost deeply.

> Il giorno 6 set 2019, alle ore 16:58, Tejun Heo <tj@kernel.org> ha scritto:
> 
> Hello, Paolo.
> 
> On Fri, Sep 06, 2019 at 11:07:17AM +0200, Paolo Valente wrote:
>> email.  As for the filesystem, I'm interested in ext4, because it is
>> the most widely used file system, and, with some workloads, it makes
> 
> Ext4 can't do writeback control as it currently stands.  It creates
> hard ordering across data writes from different cgroups.  No matter
> what mechanism you use for IO control, it is broken.  I'm sure it's
> fixable but does need some work.
> 

Yep.  However, with read+write mixes, bfq controls I/O while io.cost
fails.

> That said, read-only tests like you're doing should work fine on ext4
> too but the last time I tested io control on ext4 is more than a year
> ago so something might have changed in the meantime.
> 
> Just to rule out this isn't what you're hitting.  Can you please run
> your test on btrfs with the following patchset applied?
> 
> http://lkml.kernel.org/r/20190710192818.1069475-1-tj@kernel.org
> 

I've run tests with btrfs too, things get better, but the same issues
show up with other workloads.  This is one of the reasons why I
decided to analyze the problem more deeply (see below).

> And as I wrote in the previous reply, I did run your benchmark on one
> of the test machines and it did work fine.
> 

To address this issue we repeated the same tests on a lot of different
drives and machines.  Here is a list:
- PLEXTOR SATA PX-256M5S SSD, mounted on a Thinkpad W520
- HITACHI HTS72755 HDD, mounted on a Thinkpad W520
- WDC WD10JPVX-22JC3T0 HDD, mounted on an Acer V3-572G-75CA
- TOSHIBA MQ04ABF1 HDD, mounted on a Dell G5 5590
- Samsung SSD 860 (500GB), mounted on ThinkPad X1 Extreme

Same outcome.

So, as I wrote above, I decided to analyze io.cost in depth, and to
try to understand why it fails with some workloads.  I've been writing
my findings in an article.

I'm pasting the latex source of the (relatively long) section of this
article devoted to explaining the failures of io.cost with come
workloads.  If this text is not enough, I'm willing to share the full
article privately.


In this section we provide an explanation for each of the two failures
of \iocost shown in the previous figures for some workloads: failure
to guarantee a fair bandwidth distribution and failure to reach a high
throughput. Then, in view of these explanations, we point out why \bfq
does not suffer from this problem. Let us start by stating the root
cause for both failures.

Drives have very complex transfer functions, because of multiple
channels, in-channel pipelines, striping, locality-dependent
parallelism, \emph{readahead}, I/O-request reordering, garbage
collection, wearing, ... In particular, these features make the
parameters of transfer functions non-linear, and variable with time
and workloads. They also make these parameters hard to know or to
compute precisely. Yet virtually all parameters of a transfer function
play a non-negligible role in the actual behavior of a drive.

This important issue affects \iocost, because \iocost controls I/O by
using exactly two time-varying, and hard-to-know-precisely parameters
(of the transfer function of a drive). Incidentally, \iolatency
controls I/O with a throttling logic somehow similar to that of
\iocost, but based on much poorer knowledge of the transfer function
of the drive.

The parameters used by \iocost are I/O costs and device-rate
saturation. I/O costs affect the effectiveness of \iocost in both
distributing bandwidth fairly and reaching a high throughput. We
analyze the way I/O costs are involved in the
fair-bandwidth-distribution failure first. Then we consider device
saturation, which is involved only in the failure in reaching a high
throughput.

\iocost currently uses a linear-cost model, where each I/O is
classified as sequential or random, and as a read or a write. Each
class of I/O is assigned a base cost and a cost coefficient. The cost
of an I/O request is then computed as the sum of the base cost for its
class of I/O, and of a variable cost, equal to the cost coefficient
for its class of I/O multiplied by the size of the I/O.  Using these
estimated I/O costs, \iocost estimates the service received by each
group, and tries to let each active group receive an amount of
estimated service proportional to its weight. \iocost attains this
goal by throttling groups that would receive more than their target
service if not suspended for a while.

Both the base cost and the cost coefficient for an I/O request depend
only on the class of I/O of the request, and are independent of any
other parameter. In contrast, because of the opposite effects of, on
one side, interference by other groups, and, on the other side,
parallelism, pipelining, and any other sort of drive internal
optimization, both the actual base cost of the same I/O request, and
the very law by which the total cost of the request grows with the
size of the request, may vary greatly with the workload mix and with
the time. So they may vary even as a function of how \iocost itself
modifies the I/O pattern by throttling groups. Finally, I/O
workloads---and therefore I/O costs---may vary with the filesystem
too, given the same sequence of userspace I/O operations.

The resulting deviations between estimated and actual I/O costs may
lead to deviations between the estimated and the actual amounts of
service received by groups, and therefore to bandwidth distributions
that, for the same set of group weights, may deviate highly from each
other, and from fair distributions. Before showing this problem at
work in one of the benchmarks, we need to introduce one more bit of
information on \iocost.

\iocost does take into account issues stemming from an inaccurate
model; but only in terms of consequences on (total) throughput. In
particular, to avoid that throughput drops because too much drive time
is being granted to a low-throughput group, \iocost dynamically
adjusts group weights internally, so as to make each group donate time
to other groups, if this donation increases total throughput without
penalizing the donor.

Yet, the above deviation between estimated and actual amounts of
service may make it much more difficult, or just impossible, for this
feedback-loop to converge to weight adjustments that are stable and
reach a high throughput.

This last problem may be exacerbated by two more issues. First \iocost
evaluates the service surplus or lag for a group by comparing
the---possibly wrongly---estimated service received by the group with
a threshold computed heuristically. In particular, this threshold is
not computed as a function of the dynamically varying parameters of
the transfer function of the drive.  Secondly, weights are correctly
changed in a direction that tends to bring target quantities back in
the heuristically accepted ranges, but changes are heuristically
applied with a timing and an intensity that does not take into account
how and with what delay these changes modify I/O costs and target
quantities themselves.

Depending on the actual transfer function of a drive, the combination
of these imprecise-estimation and heuristic-update issues may make it
hard for \iocost to control per-group I/O bandwidths in a stable and
effective way. A real-life example may make it easier to understand
the problem. After this example, we will finally apply the above facts
to one of the scenarios in which \iocost fails to distribute
bandwidths fairly.

Consider a building where little or no care has been put in
implementing a stable and easy-to-control water-heating
system. Enforcing a fair I/O bandwidth distribution, while at the same
time using most of the speed of the drive, is as difficult as getting
the shower temperature right in such a building. Knob rotations
stimulate, non-linearly, a non-linear system that reacts with
time-varying delays. Until we become familiar with the system, we know
its parameters so little that we have almost no control on the
temperature of the water. In addition, even after we make it to get
the temperature we desire, changes in the rest of the system (e.g.,
one more shower open) may change parameters so much to make us burn
ourselves with no action from our side!

The authors of \iocost and \iolatency did make it to get the right
temperature for their \emph{showers}, because, most certainly, they
patiently and skillfully tuned parameters, and modified algorithms
where/as needed.  But the same tweaks may not work on different
systems. If a given I/O-cost model and feedback-loop logic do not
comply with some parameters of the transfer function of a drive, then
it may be hard or impossible to find a QoS and I/O-cost configuration
that work.

We can now dive into the details of a failure case. We instrumented
\iocost so as to trace the value of some of its internal
parameters~\cite{io.cost-tracing} over time. Group weights are one of
the traced parameters. Figure~\ref{fig:group-weights} shows the values
of the weights of the target and of one of the interferers (all
interferers exhibit the same weight fluctuation) during the benchmark
whose results are shown in the third subplot in
Figure~\ref{fig:SSD-rand-interferers}. In this subplot, a target doing
sequential reads eats almost all the bandwidth, at the expense of
interferers doing random reads. As for weights, \iocost detects,
cyclically, that interferers get a service surplus, and therefore it
cyclically lowers their weights, progressively but very quickly. Then
this make the estimated service of the interfers lag above the
threshold, which triggers a weight reset. At this point, the loop
restarts.

The negligible total bandwidth obtained by interferers clearly shows
that \iocost is throttling interferers too much, because of their I/O
cost, and is also lowering interferer weights too much. The periodic
weight reset does not balance the problem.

\begin{figure}
  \includegraphics[width=\textwidth]{plots/weights-seq_rd_vs_rand_rd.png}
  \caption{Per-group weights during the benchmark.}
  \label{fig:group-weights}
\end{figure}

The other failure of \iocost concerns reaching a high throughput.  To
describe this failure we need to add one last bit of information on
\iocost internals. \iocost dispatches I/O to the drive at an overall
rate proportional to a quantity named \emph{virtual rate}
(\vrate). \iocost dynamically adjusts the \vrate, so as to try to keep
the drive always close to saturation, but not overloaded. To this
goal, \iocost computes, heuristically, the \emph{busy level} of the
drive, as a function of, first, the number of groups in service
surplus and the number of groups lagging behind their target service,
and, secondly, of I/O-request latencies. So, all the inaccuracy issues
pointed out so far may affect the computation of the busy level and
thus of the \vrate, plus the following extra issue.

Some I/O flows may suffer from a high or low per-request latency even
if the device is actually not so close or very close to saturation,
respectively. This may happen because of the nature of the flows,
because of interference, or because of both reasons. So, depending on
the I/O pattern, the same per-requests latency may have a different
meaning in terms of actual device saturation.  In this respect,
\iocost itself modifies the I/O pattern by changing the \vrate.  But,
to evaluate saturation, \iocost compares request latencies with a
heuristic, fixed threshold, and compares the number of requests above
threshold with a further heuristic, fixed threshold. Unfortunately,
these fixed thresholds do not and cannot take the above facts into
account (thresholds can be modified by the user, but this does not
change the essence of the problem).

The combination of all these issues may lead \iocost to lower or
increase \vrate wrongly, and to establish a \vrate fluctuation that
neither ends nor converges, at least on average, to a good I/O
throughput. This is exactly what happens during the throughput failure
reported in the third subplot in Figure~\ref{fig:SSD-seq-interferers}
(both target and interferers doing sequential reads). Figure
~\ref{fig:vrate} shows the curves for the busy level, the number of
groups detected as lagging and finally the \vrate (all traced with our
tracing patch~\cite{io.cost-tracing}). The \vrate starts with a
relatively high, although fluctuating, value. Yet, around time 10,
\iocost detects a sudden rise of the busy level, which triggers a
sudden drop of \vrate. \vrate remains stably low until time $\sim$23,
when \iocost detects a low busy level and raises \vrate. But this
raising causes a new rising of the busy level, which this time goes on
for a while, causing \iocost to lower \vrate much more. Finally, from
about time 23, the number of groups lagging starts to grow, which
convinces \iocost to begin increasing the \vrate (slowly) again. All
these detections of device saturations are evidently false positives,
and result only in \iocost underutilizing the speed of the drive. The
weight-adjusting mechanism is failing as well in boosting
throughput. In particular, the weights of all groups remain constantly
equal to 100 (not shown).

\begin{figure}
  \includegraphics[width=\textwidth]{plots/vrate-seq_rd_vs_seq_rd.png}
  \caption{Busy level, number of groups lagging and \vrate during the
    benchmark.}
  \label{fig:vrate}
\end{figure}

As a last crosstest, we traced \iocost also for the throughput failure
reported in the last subplot in Figure~\ref{fig:SSD-seq-interferers}
(target doing sequential reads and interferes doing sequential
writes). Results are reported in Figure~\ref{fig:vrate-writes}, and
show the same \vrate estimation issues as in the failure with only
reads.

\begin{figure}
  \includegraphics[width=\textwidth]{plots/vrate-seq_rd_vs_seq_wr.png}
  \caption{Busy level, number of groups lagging and \vrate during the
    benchmark.}
  \label{fig:vrate-writes}
\end{figure}

The remaining question is then: why does \bfq make it?  \bfq makes it
because it \textbf{does not} use any transfer-function parameter to
provide its main service guarantee. \bfq's main actuators are simply
the fixed weights set by the user; and, given the total number of
sectors transferred in a given time interval, \bfq just provides each
process or group with a fraction of those sectors proportional to the
weight of the process or group. There are feedback-loop mechanisms in
\bfq too, but they intervene only to boost throughput. This is
evidently an easier task than the combined task of boosting throughput
and at the same time guaranteeing bandwidth and latency. Moreover,
even if throughput boosting fails for some workload, service
guarantees are however preserved.

Thanks,
Paolo


> Thanks.
> 
> -- 
> tejun

